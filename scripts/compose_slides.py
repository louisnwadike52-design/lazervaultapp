#!/usr/bin/env python3
"""Composite the dashboard carousel slides: photo + brand gradient + text scrim.

WHY A COMPOSITE AND NOT THE BARE PHOTO
Three problems a raw photo has in this slot, all solved by the same overlay:

  1. Legibility. The headline and subline are drawn by Flutter over the image
     (see _AdvertCard). A photo with a bright left third makes white text
     unreadable, and we cannot know in advance where a replacement photo will be
     bright.
  2. Cohesion. The five photos come from different shoots with different colour
     casts — one is olive-backed, one is near-monochrome. Side by side in a
     swiping strip they look like five unrelated adverts.
  3. Crop. The card is ~3.3:1. A 3:2 photo has to lose 45% of its height, so the
     band has to be chosen per photo rather than taken from the centre.

So: crop to the card's ratio with a per-photo focal point, lay the brand purple
over it, then a left-weighted scrim under the text. The photo still carries the
warmth and the human subject; the overlay makes it ours.

Output: 1242x376 (3.3:1, @3x for the 414pt design width) WebP.
"""

import base64
import os
import subprocess
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
SRC = HERE + "/photos"
OUT = HERE + "/slides_photo"
W, H = 1242, 376

# object-position picks the band of the photo that survives the 3.3:1 crop, and
# nudges the subject away from the left third where the text sits.
SLIDES = [
    # name         source file        focal point      brand tint (from → to)
    ("bills",      "bills.jpg",       "62% 42%", "#4E03D0", "#7C3AED"),
    ("transfers",  "c_street.jpg",    "52% 14%", "#1D4ED8", "#4F46E5"),
    ("remittance", "c_embankment.jpg","62% 40%", "#065F46", "#0D9488"),
    ("crypto",     "c_hoodie.jpg",    "62% 38%", "#B45309", "#D97706"),
    ("savings",    "c_rand.jpg",      "58% 45%", "#9D174D", "#BE185D"),
]


def data_uri(path: str) -> str:
    with open(path, "rb") as f:
        return "data:image/jpeg;base64," + base64.b64encode(f.read()).decode()


def html(img: str, focal: str, c1: str, c2: str) -> str:
    return f"""<!doctype html><html><head><meta charset="utf-8"><style>
  html,body {{ margin:0; padding:0; width:{W}px; height:{H}px; overflow:hidden; }}
  .card {{ position:relative; width:{W}px; height:{H}px; }}
  .photo {{ position:absolute; inset:0; width:100%; height:100%;
            object-fit:cover; object-position:{focal}; }}
  /* Brand wash. Multiply keeps the photo's own shadows instead of flattening
     it to a colour block the way a plain alpha fill does. */
  .tint {{ position:absolute; inset:0; mix-blend-mode:multiply;
           background:linear-gradient(115deg, {c1} 0%, {c2} 100%); opacity:0.72; }}
  /* A little brand colour back on top so the darkest areas do not go muddy. */
  .lift {{ position:absolute; inset:0; mix-blend-mode:screen;
           background:linear-gradient(115deg, {c1} 0%, transparent 70%); opacity:0.22; }}
  /* Text scrim: heaviest under the headline, gone by the right third so the
     subject stays visible. */
  .scrim {{ position:absolute; inset:0; background:linear-gradient(90deg,
            rgba(0,0,0,0.62) 0%, rgba(0,0,0,0.42) 38%, rgba(0,0,0,0.10) 68%,
            rgba(0,0,0,0) 100%); }}
</style></head><body>
  <div class="card">
    <img class="photo" src="{img}">
    <div class="tint"></div>
    <div class="lift"></div>
    <div class="scrim"></div>
  </div>
</body></html>"""


def main():
    os.makedirs(OUT, exist_ok=True)
    chromium = subprocess.run(
        ["bash", "-lc",
         "find ~/Library/Caches/ms-playwright/chromium-*/ -maxdepth 5 -type f "
         "\\( -name Chromium -o -name 'Google Chrome for Testing' \\) 2>/dev/null | tail -1"],
        capture_output=True, text=True).stdout.strip()
    if not chromium:
        sys.exit("no chromium found")

    for name, src, focal, c1, c2 in SLIDES:
        path = f"{SRC}/{src}"
        if not os.path.exists(path):
            print(f"  SKIP {name}: missing {src}")
            continue
        page = f"{OUT}/{name}.html"
        png = f"{OUT}/{name}.png"
        webp = f"{OUT}/{name}.webp"
        with open(page, "w") as f:
            f.write(html(data_uri(path), focal, c1, c2))
        subprocess.run([
            chromium, "--headless", "--disable-gpu", "--hide-scrollbars",
            f"--screenshot={png}", f"--window-size={W},{H}", f"file://{page}",
        ], check=True, capture_output=True)
        # q=82 on a photo under a heavy tint: the gradient hides the artefacts a
        # bare photo would show, and it keeps each slide well under the 256KB the
        # whole dashboard_adverts setting is capped at.
        subprocess.run(["cwebp", "-q", "82", "-quiet", png, "-o", webp], check=True)
        print(f"  {name:12s} {os.path.getsize(webp)/1024:6.1f} KB")
        os.remove(page)


if __name__ == "__main__":
    main()
