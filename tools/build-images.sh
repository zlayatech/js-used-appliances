#!/usr/bin/env bash
# Rebuilds the responsive images in assets/img/ from the originals in _source/.
# macOS only (uses the built-in `sips`). Run from anywhere: tools/build-images.sh
#
#   _source/logo.jpg        JS Used Appliances logo (1448x1086, black background)
#   _source/photos/*.jpg    store photos: fridge, range, washer, dryer, showroom
#                           (dryer.jpg has a price sticker cropped off the top)
#
# _source/ is not committed. To swap a photo, replace the file and rerun this script.
set -euo pipefail
cd "$(dirname "$0")/.."

SRC=_source
OUT=assets/img
mkdir -p "$OUT"

# build <output-name> <source-file> <jpeg-quality> <avif-quality> <width> [<width> ...]
# Never upscales: widths larger than the source are skipped.
build() {
  local name=$1 src=$2 jq=$3 aq=$4; shift 4
  [[ -f "$src" ]] || { echo "missing source: $src" >&2; exit 1; }
  local sw
  sw=$(sips -g pixelWidth "$src" | awk '/pixelWidth/{print $2}')
  for w in "$@"; do
    if (( w > sw )); then continue; fi
    sips -s format jpeg -s formatOptions "$jq" --resampleWidth "$w" "$src" --out "$OUT/$name-$w.jpg" >/dev/null
    sips -s format avif -s formatOptions "$aq" --resampleWidth "$w" "$src" --out "$OUT/$name-$w.avif" >/dev/null
    printf '  %-10s %5spx  jpg %7s B  avif %7s B\n' "$name" "$w" \
      "$(wc -c < "$OUT/$name-$w.jpg" | tr -d ' ')" "$(wc -c < "$OUT/$name-$w.avif" | tr -d ' ')"
  done
}

# The logo is the hero banner: keep it crisp.
build logo "$SRC/logo.jpg" 78 66 160 640 960 1448
# sips re-encodes the full-size JPEG larger than the original, so ship the original.
cp "$SRC/logo.jpg" "$OUT/logo-1448.jpg"

for photo in fridge range washer dryer showroom; do
  build "$photo" "$SRC/photos/$photo.jpg" 62 52 480 750
done
