"""
Process Play Store screenshots:
- Crop to 1080x1920 (Play Store recommended 9:16)
- Cut top status bar (80px) and bottom area (incl. test ad band) (~400px)
- Crop region: x=0-1080, y=80-2000 (1080 wide x 1920 tall)
- Rename to ordered: 01_initial, 02_running, 03_complete, 04_stats, 05_history
"""
from PIL import Image
import os

RAW = r"C:\plank_app\assets\screenshots\raw_20260508"
OUT = r"C:\plank_app\assets\screenshots\final"
os.makedirs(OUT, exist_ok=True)

# Source -> Final name mapping (skip the JP custom dialog -- raw 4)
mapping = [
    ("1_135120.png", "01_initial.png"),
    ("2_135718.png", "02_running.png"),
    ("3_135745.png", "03_complete.png"),
    ("5_140154.png", "04_stats.png"),
    ("6_140218.png", "05_history.png"),
]

# Crop box: (left, top, right, bottom)
# 1080x2400 -> 1080x1920 by cutting 120 from top (status bar gone), 360 from bottom (test ad gone)
CROP = (0, 120, 1080, 2040)

for src_name, dst_name in mapping:
    src_path = os.path.join(RAW, src_name)
    dst_path = os.path.join(OUT, dst_name)
    with Image.open(src_path) as im:
        w, h = im.size
        print(f"  {src_name}: {w}x{h}")
        cropped = im.crop(CROP)
        cw, ch = cropped.size
        # Optimize PNG
        cropped.save(dst_path, "PNG", optimize=True)
        print(f"  -> {dst_name}: {cw}x{ch}")

# List final results
print("\nFinal screenshots:")
for f in sorted(os.listdir(OUT)):
    full = os.path.join(OUT, f)
    sz = os.path.getsize(full)
    with Image.open(full) as im:
        w, h = im.size
    print(f"  {f}: {w}x{h}, {sz/1024:.0f} KB")
