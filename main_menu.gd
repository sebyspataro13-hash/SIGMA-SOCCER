extends Control

# SIGMA SOCCER - schermata principale statica
# Tutti gli elementi sono disegnati: non ci sono pulsanti o funzioni cliccabili.

const BG := Color("#07131d")
const PANEL := Color("#102331")
const WHITE := Color("#f4f7f8")
const MUTED := Color("#9eb0ba")
const CYAN := Color("#55e6d0")
const LIME := Color("#c9f36a")
const ORANGE := Color("#ff925c")

func _ready() -> void:
    set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
    queue_redraw()

func _notification(what: int) -> void:
    if what == NOTIFICATION_RESIZED:
        queue_redraw()

func _draw() -> void:
    var s := get_viewport_rect().size
    var w := s.x
    var h := s.y
    var font := ThemeDB.fallback_font
    var scale := min(w / 1280.0, h / 720.0)
    var margin := 42.0 * scale

    # Sfondo e luce dello stadio
    draw_rect(Rect2(Vector2.ZERO, s), BG)
    draw_polygon(PackedVector2Array([
        Vector2(w * 0.42, 0), Vector2(w, 0), Vector2(w, h * 0.76),
        Vector2(w * 0.70, h * 0.62), Vector2(w * 0.48, h * 0.34)
    ]), PackedColorArray([Color("#123847")]))
    draw_rect(Rect2(0, h * 0.66, w, h * 0.34), Color("#091b23"))
    # Gradinate geometriche
    for i in range(7):
        var y := h * (0.25 + i * 0.055)
        draw_line(Vector2(w * 0.38, y), Vector2(w, y + h * 0.08), Color(0.28, 0.55, 0.57, 0.20), 2.0 * scale)
    # Campo lontano
    draw_polygon(PackedVector2Array([
        Vector2(w * 0.50, h * 0.72), Vector2(w, h * 0.63),
        Vector2(w, h), Vector2(w * 0.22, h)
    ]), PackedColorArray([Color("#123b35")]))
    draw_line(Vector2(w * 0.50, h * 0.72), Vector2(w, h * 0.63), Color(0.55, 0.85, 0.73, 0.35), 2.0 * scale)
    draw_line(Vector2(w * 0.22, h), Vector2(w, h * 0.83), Color(0.55, 0.85, 0.73, 0.24), 2.0 * scale)

    # Header
    draw_rect(Rect2(0, 0, w, 92 * scale), Color(0.02, 0.07, 0.10, 0.78))
    draw_string(font, Vector2(margin, 42 * scale), "SIGMA", HORIZONTAL_ALIGNMENT_LEFT, -1, int(25 * scale), WHITE)
    draw_string(font, Vector2(margin, 66 * scale), "SOCCER", HORIZONTAL_ALIGNMENT_LEFT, -1, int(13 * scale), CYAN)
    var nav_y := 52 * scale
    var nav_x := w * 0.39
    var nav := ["HOME", "GIOCA", "CLUB", "NEGOZIO"]
    for i in range(nav.size()):
        var col := CYAN if i == 0 else Color("#c4d0d4")
        draw_string(font, Vector2(nav_x + i * 105 * scale, nav_y), nav[i], HORIZONTAL_ALIGNMENT_LEFT, -1, int(13 * scale), col)
    draw_string(font, Vector2(w - margin - 155 * scale, nav_y), "STAGIONE 01   •   ITALIA", HORIZONTAL_ALIGNMENT_RIGHT, 190 * scale, int(10 * scale), MUTED)

    # Hero title
    draw_string(font, Vector2(margin, h * 0.285), "LA TUA", HORIZONTAL_ALIGNMENT_LEFT, -1, int(20 * scale), CYAN)
    draw_string(font, Vector2(margin - 3 * scale, h * 0.405), "LEGGENDA.", HORIZONTAL_ALIGNMENT_LEFT, -1, int(66 * scale), WHITE)
    draw_string(font, Vector2(margin, h * 0.465), "COMINCIA QUI.", HORIZONTAL_ALIGNMENT_LEFT, -1, int(30 * scale), LIME)
    draw_string(font, Vector2(margin, h * 0.525), "Costruisci la tua squadra. Entra in campo.", HORIZONTAL_ALIGNMENT_LEFT, -1, int(15 * scale), MUTED)
    draw_string(font, Vector2(margin, h * 0.56), "Vivi il calcio, scrivi la tua storia.", HORIZONTAL_ALIGNMENT_LEFT, -1, int(15 * scale), MUTED)

    # Calciatore stilizzato in silhouette, decorativo
    var px := w * 0.73
    var py := h * 0.46
    draw_circle(Vector2(px, py - 105 * scale), 29 * scale, Color("#d5e2df"))
    draw_polygon(PackedVector2Array([
        Vector2(px - 38 * scale, py - 70 * scale), Vector2(px + 35 * scale, py - 70 * scale),
        Vector2(px + 55 * scale, py + 25 * scale), Vector2(px - 48 * scale, py + 25 * scale)
    ]), PackedColorArray([Color("#142d3a")]))
    draw_polygon(PackedVector2Array([
        Vector2(px - 33 * scale, py + 15 * scale), Vector2(px + 4 * scale, py + 18 * scale),
        Vector2(px - 28 * scale, py + 122 * scale), Vector2(px - 68 * scale, py + 116 * scale)
    ]), PackedColorArray([Color("#e8f0ec")]))
    draw_polygon(PackedVector2Array([
        Vector2(px + 4 * scale, py + 18 * scale), Vector2(px + 48 * scale, py + 14 * scale),
        Vector2(px + 91 * scale, py + 95 * scale), Vector2(px + 55 * scale, py + 117 * scale)
    ]), PackedColorArray([Color("#e8f0ec")]))
    draw_line(Vector2(px - 12 * scale, py - 55 * scale), Vector2(px - 78 * scale, py + 15 * scale), Color("#d5e2df"), 17 * scale)
    draw_line(Vector2(px + 23 * scale, py - 55 * scale), Vector2(px + 82 * scale, py - 5 * scale), Color("#d5e2df"), 17 * scale)
    draw_circle(Vector2(px + 125 * scale, py + 113 * scale), 17 * scale, WHITE)
    draw_circle(Vector2(px + 125 * scale, py + 113 * scale), 17 * scale, Color(0.05, 0.12, 0.15, 0.0), false, 2.0 * scale)

    # Etichetta evento
    draw_rect(Rect2(w * 0.70, h * 0.18, 210 * scale, 31 * scale), Color(0.08, 0.22, 0.25, 0.92))
    draw_string(font, Vector2(w * 0.70 + 13 * scale, h * 0.18 + 21 * scale), "●  NUOVA STAGIONE", HORIZONTAL_ALIGNMENT_LEFT, -1, int(11 * scale), LIME)

    # Pannelli inferiori: solo grafica, nessuna interazione
    var card_y := h * 0.72
    var card_h := h * 0.205
    var gap := 14 * scale
    var card_w := (w - margin * 2 - gap * 3) / 4.0
    var titles := ["ULTIMATE CLUB", "NEGOZIO", "OBIETTIVI", "STADIO"]
    var subs := ["La tua squadra, la tua storia", "Novità e personalizzazione", "Completa le sfide", "La casa del tuo club"]
    var tags := ["01  /  CLUB", "02  /  MARKET", "03  /  SFIDE", "04  /  ARENA"]
    var accents := [CYAN, ORANGE, LIME, Color("#8ba8ff")]
    for i in range(4):
        var x := margin + i * (card_w + gap)
        draw_rect(Rect2(x, card_y, card_w, card_h), PANEL)
        draw_rect(Rect2(x, card_y, card_w, 4 * scale), accents[i])
        draw_string(font, Vector2(x + 16 * scale, card_y + 27 * scale), tags[i], HORIZONTAL_ALIGNMENT_LEFT, -1, int(9 * scale), accents[i])
        draw_string(font, Vector2(x + 16 * scale, card_y + card_h * 0.60), titles[i], HORIZONTAL_ALIGNMENT_LEFT, card_w - 24 * scale, int(16 * scale), WHITE)
        draw_string(font, Vector2(x + 16 * scale, card_y + card_h * 0.80), subs[i], HORIZONTAL_ALIGNMENT_LEFT, card_w - 24 * scale, int(10 * scale), MUTED)

    draw_string(font, Vector2(margin, h - 14 * scale), "SIGMA SOCCER  •  IL TUO CAMPO, LE TUE REGOLE", HORIZONTAL_ALIGNMENT_LEFT, -1, int(9 * scale), Color("#6f8791"))
    draw_string(font, Vector2(w - margin, h - 14 * scale), "MENU PRINCIPALE  /  CONCEPT", HORIZONTAL_ALIGNMENT_RIGHT, -1, int(9 * scale), Color("#6f8791"))
