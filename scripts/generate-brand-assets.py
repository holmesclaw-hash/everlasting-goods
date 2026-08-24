#!/usr/bin/env python3
"""Generate reproducible Everlasting Goods brand assets."""

from __future__ import annotations

from pathlib import Path

from PIL import Image, ImageDraw, ImageFont

ROOT = Path(__file__).resolve().parents[1]
PUBLIC = ROOT / "public"
IMAGES = PUBLIC / "images"
IMAGES.mkdir(parents=True, exist_ok=True)

FOREST = "#2D5016"
FOREST_DARK = "#1D3410"
CREAM = "#FAFAF5"
CREAM_DARK = "#EEEED8"
GOLD = "#8B6914"
CHARCOAL = "#1A1A1A"


def font(name: str, size: int) -> ImageFont.ImageFont | ImageFont.FreeTypeFont:
    candidates = [
        Path("/System/Library/Fonts/Supplemental") / name,
        Path("/Library/Fonts") / name,
    ]
    for candidate in candidates:
        if candidate.exists():
            return ImageFont.truetype(str(candidate), size)
    return ImageFont.load_default(size=size)


serif_bold = font("Georgia Bold.ttf", 72)
serif_medium = font("Georgia.ttf", 40)
sans = font("Arial.ttf", 27)
icon_font = font("Georgia Bold.ttf", 270)

icon = Image.new("RGB", (512, 512), FOREST)
draw = ImageDraw.Draw(icon)
draw.ellipse((42, 42, 470, 470), outline=CREAM_DARK, width=10)
draw.arc((76, 76, 436, 436), 210, 330, fill=GOLD, width=18)
letter_box = draw.textbbox((0, 0), "E", font=icon_font)
letter_x = (512 - (letter_box[2] - letter_box[0])) / 2
letter_y = (512 - (letter_box[3] - letter_box[1])) / 2 - 34
draw.text((letter_x, letter_y), "E", font=icon_font, fill=CREAM)
icon.save(PUBLIC / "icon.png", optimize=True)

og = Image.new("RGB", (1200, 630), CREAM)
draw = ImageDraw.Draw(og)
draw.rectangle((0, 0, 1200, 28), fill=FOREST)
draw.rectangle((0, 540, 1200, 630), fill=FOREST_DARK)
draw.rounded_rectangle((72, 74, 1128, 500), radius=28, fill=CREAM_DARK)
draw.ellipse((100, 112, 254, 266), fill=FOREST)
draw.arc((119, 131, 235, 247), 210, 330, fill=GOLD, width=8)
small_icon_font = font("Georgia Bold.ttf", 88)
small_box = draw.textbbox((0, 0), "E", font=small_icon_font)
draw.text((177 - (small_box[2] - small_box[0]) / 2, 173 - (small_box[3] - small_box[1]) / 2 - 10), "E", font=small_icon_font, fill=CREAM)
draw.text((300, 113), "Everlasting Goods", font=serif_bold, fill=CHARCOAL)
draw.text((302, 212), "BUY IT FOR LIFE", font=sans, fill=GOLD)
draw.line((302, 264, 1045, 264), fill=FOREST, width=4)
draw.text((302, 302), "Buy less. Buy better.", font=serif_medium, fill=FOREST_DARK)
draw.text((302, 374), "Evidence-led guides to durable, repairable products", font=sans, fill=CHARCOAL)
draw.text((76, 564), "everlasting-goods.com", font=sans, fill=CREAM)
og.save(IMAGES / "og-default.png", optimize=True)

print(PUBLIC / "icon.png")
print(IMAGES / "og-default.png")
