# Oyun şablonu: Godot 4.7 (2D ve 3D)

*English below.*

Bu şablonla yaptığın oyun, Oyun Takımı sitesinde yayınlanır. Telefonda da bilgisayarda da çalışmalı.

[Godot](https://godotengine.org) ücretsiz, açık kaynaklı bir oyun motorudur. Sahneleri görsel bir editörde kurarsın, kodu Python'a benzeyen **GDScript** ile yazarsın. Oyunu Godot'ta web için dışa aktarırsın (`build/` klasörü) ve projeyle birlikte repoya gönderirsin; site o hazır oyunu yayınlar.

- İndir: https://godotengine.org/download (**Godot 4.7**, .NET olmayan sürüm)
- Belgeler: https://docs.godotengine.org

## Başlarken
1. Bu sayfada **Use this template → Create a new repository** de. Repoyu kendi hesabında **Private** olarak oluştur.
   **Repo adı kuralı (zorunlu):** `adın_soyadın-oyunun_adı`. Örnek: Berfin Toprak'ın Gece Lambası oyunu `berfin_toprak-gece_lambasi`. Hepsi küçük harf; Türkçe harfleri sadeleştir (ç→c, ğ→g, ı→i, ö→o, ş→s, ü→u); kelimeler arasına `_`, adınla oyunun adı arasına tek bir `-` koy. Böylece hangi oyunu kimin yaptığı görülür. Repo adı sitede görünmez; oyunun adresi `game.json`'daki `slug`'dır (örn. `gece-lambasi`).
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
**Göndermeden önce dışa aktar:** Godot'ta **Project → Export… → Web → Export Project**, dosya adı `build/index.html` (ayar hazır). İlk seferde Godot web şablonlarını indirmeni ister (**Editor → Manage Export Templates → Download**). Sonra `build/` klasörünü de commit'le. Dışa aktarmadan push'larsan sitede eski sürüm kalır. Oyun bitince repoyu asistanına transfer et (**Settings → Danger Zone → Transfer**). Repo `oyun-team` organizasyonuna taşındıktan sonra, `main`'e her push oyunu otomatik yayınlar. İlk yayın asistan onayladıktan sonra görünür.

Yayın sonucunu GitHub'da son commit'in yanındaki işarette görürsün: ✓ ya da ✗ (**oyun-team / yayın**; üzerine gelince mesajı okunur). GitHub Actions kullanılmaz; site her push'u kendisi alır.

Transfer yapamıyorsan, oyun bir fork ise, dal adı `main` değilse ya da push'tan sonra işaret çıkmıyorsa: [AGENTS.md](AGENTS.md) dosyasının 2. bölümü her durumu adım adım anlatır. Bir yapay zekâ kod asistanı kullanıyorsan ona "AGENTS.md'ye göre oyunu oyun-team'e taşı" demen yeterli.

---

# Game template: Godot 4.7 (2D and 3D)

Games made from this template are published on the Oyun Team site. They must work on phones and computers.

[Godot](https://godotengine.org) is a free, open-source game engine: you build scenes in a visual editor and write code in **GDScript**, which looks like Python. You export the game for the web in Godot (the `build/` folder) and push it with the project; the site publishes that export. Download **Godot 4.7** (not the .NET build) from https://godotengine.org/download. Docs: https://docs.godotengine.org.

**Getting started:** click **Use this template**, create a **private** repo on your account named `firstname_lastname-game_name` (a strict rule, so we can see who made what: for example `berfin_toprak-gece_lambasi`; lowercase, Turkish letters made plain, `_` between words, one `-` between your name and the game; details in section 2.9 of [AGENTS.md](AGENTS.md)), and add your TA as a collaborator. Fill in `game.json` (`slug`, `title`, `author` as a nickname, `category`, `orientation`; leave `dir` as `build`). In Godot, **Import** `project/project.godot`. `main.tscn` and `main.gd` are an example game, Target Hunter, that you can replace.

**Godot rules:** GDScript only (C# Godot games are not supported on this site). Keep the **Compatibility** renderer. Don't change the **Web** preset in `project/export_presets.cfg`; **Thread Support** must stay off. The engine itself is about 40 MB, which leaves about 20 MB for your files. Must be playable with touch (mouse clicks become touches; use `InputEventScreenTouch`). Nothing inappropriate.

**Testing:** press **F5** in the editor, or use **Run in Browser** (top right; download the export templates the first time via **Editor → Manage Export Templates**). Outside the site the game runs in **preview mode**, with scores kept only on your computer.

**The `Oyun` autoload:** see the code block above; `await Oyun.submit_score(score)` when a round ends. Don't edit `project/oyun.gd`.

**Before every push, export:** in Godot, **Project → Export… → Web → Export Project** to `build/index.html` (the preset is ready; the first time, download the export templates via **Editor → Manage Export Templates**), then commit the `build/` folder too. Without a fresh export the site keeps the old version.

**Handing in:** transfer the repo to your TA when done. Once it is in `oyun-team`, every push to `main` publishes automatically; the first release appears after the TA approves it. The result shows as a ✓ or ✗ (**oyun-team / yayın**) next to the latest commit on GitHub; no GitHub Actions run, the site picks up each push itself. If you can't transfer, the repo is a fork, the branch isn't `main`, or no mark appears after a push, section 2 of [AGENTS.md](AGENTS.md) covers every case step by step; an AI coding assistant can follow it for you ("move this game into oyun-team following AGENTS.md").
