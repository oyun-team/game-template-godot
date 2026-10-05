# Oyun şablonu: Godot 4.7 (2D ve 3D)

*English below.*

Bu şablonla yaptığın oyun, Oyun Takımı sitesinde yayınlanır. Telefonda da bilgisayarda da çalışmalı.

[Godot](https://godotengine.org) ücretsiz, açık kaynaklı bir oyun motorudur. Sahneleri görsel bir editörde kurarsın, kodu Python'a benzeyen **GDScript** ile yazarsın. Repoya sadece Godot projesini gönderirsin; GitHub onu web için kendisi dışa aktarır.

- İndir: https://godotengine.org/download (**Godot 4.7**, .NET olmayan sürüm)
- Belgeler: https://docs.godotengine.org

## Başlarken
1. Bu sayfada **Use this template → Create a new repository** de. Repoyu kendi hesabında **Private** olarak oluştur.
2. Repo ayarlarından (**Settings → Collaborators**) asistanını collaborator olarak ekle.
3. `game.json` dosyasını doldur: `slug` (oyunun adresi, örn. `uzay-kosusu`), `title`, `author` (takma adın; gerçek adını yazmak zorunda değilsin), `category`, `orientation`. `dir` alanını `build` olarak bırak.
4. Godot'u aç, **Import** de ve `project/project.godot` dosyasını seç. `main.tscn` ve `main.gd` bir örnek oyun (Hedef Avcısı); onları değiştirip kendi oyununu yap. Resim, ses ve modelleri `project/` içine koy.

## Kurallar (Godot'a özel)
- **Sadece GDScript.** C# ile yapılan Godot oyunları bu sitede desteklenmiyor.
- Ayarlarda renderer **Compatibility** kalmalı (telefon tarayıcıları için).
- `project/export_presets.cfg` dosyasındaki **Web** ayarını değiştirme. Özellikle **Thread Support** kapalı kalmalı.
- Godot motoru tek başına yaklaşık 40 MB; senin dosyaların için yaklaşık 20 MB yer kalıyor. Büyük resimleri küçült, müzikleri `.ogg` yap.
- Dokunmatik ekranda oynanabilmeli. Fare tıklaması dokunmaya çevrilir (`InputEventScreenTouch` kullan).
- Uygunsuz içerik yok; site herkese açık.

## Bilgisayarında denemek
Godot editöründe **F5** ile oyunu çalıştır. Tarayıcıda denemek için sağ üstteki **Remote Deploy / Run in Browser** düğmesini kullan (Godot ilk seferde web şablonlarını indirmeni ister: **Editor → Manage Export Templates → Download**).
Editörde ya da sitenin dışında oyun **önizleme modunda** çalışır: skorlar sadece senin bilgisayarında tutulur.

## Siteyle konuşmak: `Oyun`
`project/oyun.gd` dosyasını değiştirme. Her script'ten `Oyun` adıyla kullanılır:
```gdscript
Oyun.get_language()                     # "tr" veya "en"
var player = await Oyun.get_player()    # { "nickname": ... } ya da giriş yapılmadıysa null
var best = await Oyun.submit_score(42)  # oyun bitince skoru gönder, en iyi skoru döner
Oyun.paused.connect(func(): ...)        # oyuncu sekmeyi değiştirdi; oyun kendiliğinden durur
Oyun.resumed.connect(func(): ...)
```
Skor kullanmıyorsan `game.json`'da `"scores": false` yap.

## Teslim
Her push'ta GitHub oyunu web için dışa aktarır ve kontrol eder (**Actions** sekmesinde görünür; kırmızı çarpı varsa tıkla ve hatayı oku). Oyun bitince repoyu asistanına transfer et (**Settings → Danger Zone → Transfer**). Repo `oyun-team` organizasyonuna taşındıktan sonra, `main`'e her push oyunu otomatik yayınlar. İlk yayın asistan onayladıktan sonra görünür.

---

# Game template: Godot 4.7 (2D and 3D)

Games made from this template are published on the Oyun Team site. They must work on phones and computers.

[Godot](https://godotengine.org) is a free, open-source game engine: you build scenes in a visual editor and write code in **GDScript**, which looks like Python. You only push the Godot project; GitHub exports it for the web. Download **Godot 4.7** (not the .NET build) from https://godotengine.org/download. Docs: https://docs.godotengine.org.

**Getting started:** click **Use this template**, create a **private** repo on your account, and add your TA as a collaborator. Fill in `game.json` (`slug`, `title`, `author` as a nickname, `category`, `orientation`; leave `dir` as `build`). In Godot, **Import** `project/project.godot`. `main.tscn` and `main.gd` are an example game, Target Hunter, that you can replace.

**Godot rules:** GDScript only (C# Godot games are not supported on this site). Keep the **Compatibility** renderer. Don't change the **Web** preset in `project/export_presets.cfg`; **Thread Support** must stay off. The engine itself is about 40 MB, which leaves about 20 MB for your files. Must be playable with touch (mouse clicks become touches; use `InputEventScreenTouch`). Nothing inappropriate.

**Testing:** press **F5** in the editor, or use **Run in Browser** (top right; download the export templates the first time via **Editor → Manage Export Templates**). Outside the site the game runs in **preview mode**, with scores kept only on your computer.

**The `Oyun` autoload:** see the code block above; `await Oyun.submit_score(score)` when a round ends. Don't edit `project/oyun.gd`.

**Handing in:** every push exports and checks the game on GitHub (see the **Actions** tab). Transfer the repo to your TA when done. Once it is in `oyun-team`, every push to `main` publishes automatically; the first release appears after the TA approves it.
