# Örnek oyun: Hedef Avcısı. Bu sahneyi ve dosyayı kendi oyununla değiştir.
# Example game: Target Hunter. Replace this scene and script with your own game.
# Godot docs / belgeler: https://docs.godotengine.org
extends Node2D

const TEXT := {
	"tr": { "start": "Başlamak için dokun", "score": "Skor", "lives": "Can", "over": "Oyun bitti!", "best": "En iyi", "again": "Tekrar oynamak için dokun", "hint": "Hedefler küçülüp kaybolmadan onlara dokun" },
	"en": { "start": "Tap to start", "score": "Score", "lives": "Lives", "over": "Game over!", "best": "Best", "again": "Tap to play again", "hint": "Tap the targets before they shrink away" },
}
const COLORS := [Color("#ff5d73"), Color("#ffb703"), Color("#4cc9f0"), Color("#c77dff"), Color("#80ed99")]

var t: Dictionary
var state := "start" # start | playing | over
var targets: Array = [] # each: { pos, radius, life, max_life, color }
var score := 0
var lives := 3
var spawn_timer := 0.0

@onready var score_label: Label = $Hud/Score
@onready var lives_label: Label = $Hud/Lives
@onready var message: Label = $Hud/Message


func _ready() -> void:
	t = TEXT.get(Oyun.get_language(), TEXT["tr"])
	message.text = t["start"] + "\n\n" + t["hint"]
	_update_hud()


func _start_round() -> void:
	targets.clear()
	score = 0
	lives = 3
	spawn_timer = 0.0
	state = "playing"
	message.text = ""
	_update_hud()


func _end_round() -> void:
	state = "over"
	message.text = "%s\n%s: %d\n\n%s" % [t["over"], t["score"], score, t["again"]]
	var best: int = await Oyun.submit_score(score)
	if best >= 0 and state == "over":
		message.text = "%s\n%s: %d\n%s: %d\n\n%s" % [t["over"], t["score"], score, t["best"], best, t["again"]]


func _spawn() -> void:
	var size := get_viewport_rect().size
	var radius := randf_range(50.0, 80.0)
	var life := maxf(1.0, 2.6 - score * 0.04) # targets vanish faster as the score grows
	targets.append({
		"pos": Vector2(randf_range(radius, size.x - radius), randf_range(140.0 + radius, size.y - radius)),
		"radius": radius, "life": life, "max_life": life, "color": COLORS.pick_random(),
	})


# Touch and mouse both arrive here (mouse is turned into touch in Project Settings).
func _unhandled_input(event: InputEvent) -> void:
	if not (event is InputEventScreenTouch and event.pressed):
		return
	if state != "playing":
		_start_round()
		return
	for i in range(targets.size() - 1, -1, -1):
		var target: Dictionary = targets[i]
		if event.position.distance_to(target["pos"]) <= _current_radius(target) * 1.15:
			targets.remove_at(i)
			score += 1
			_update_hud()
			return


func _process(delta: float) -> void:
	# While the player is away the site pauses the game, so this does not run.
	if state == "playing":
		spawn_timer -= delta
		if spawn_timer <= 0.0:
			_spawn()
			spawn_timer = randf_range(0.5, 0.9)
		for i in range(targets.size() - 1, -1, -1):
			targets[i]["life"] -= delta
			if targets[i]["life"] <= 0.0:
				targets.remove_at(i)
				lives -= 1
				_update_hud()
				if lives <= 0:
					_end_round()
					break
	queue_redraw()


func _current_radius(target: Dictionary) -> float:
	return target["radius"] * clamp(target["life"] / target["max_life"], 0.2, 1.0)


func _draw() -> void:
	draw_rect(get_viewport_rect(), Color("#1b1730"))
	for target in targets:
		var r := _current_radius(target)
		draw_circle(target["pos"], r, target["color"])
		draw_circle(target["pos"], r * 0.66, Color.WHITE)
		draw_circle(target["pos"], r * 0.33, target["color"])


func _update_hud() -> void:
	var playing := state != "start"
	score_label.text = "%s: %d" % [t["score"], score] if playing else ""
	lives_label.text = "%s: %d" % [t["lives"], lives] if playing else ""
