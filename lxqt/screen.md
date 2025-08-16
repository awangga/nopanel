mantap. Ini dua alat praktis buat kamu:

---

# 1) Script tiling jendela (`tile.sh`)

Biar cepat “nyusun” aplikasi ke kiri/kanan/atas/bawah (atau 4-kuadran) pakai shortcut.

**Dependensi (sekali saja):**

```bash
sudo apt install wmctrl xdotool x11-utils
```

**Simpan sebagai `~/bin/tile.sh` (buat folder kalau belum ada) dan beri izin eksekusi:**

```bash
mkdir -p ~/bin
nano ~/bin/tile.sh
chmod +x ~/bin/tile.sh
```

**Isi filenya:**

```bash
#!/usr/bin/env bash
# Simple tiling for LXQt/X11 using wmctrl + xdotool
# Usage: tile.sh left|right|top|bottom|tl|tr|bl|br|max|center

set -e

# --- Dapatkan resolusi layar utama (primary) ---
get_screen() {
  # coba deteksi monitor primary
  if xrandr --current | grep -q " primary "; then
    xrandr --current | awk '/ primary / && /\*/ {print $4}' | head -n1
  else
    # fallback: resolusi pertama yang aktif
    xrandr --current | awk '/\*/ {print $1; exit}'
  fi
}

RES=$(get_screen)          # contoh: 1920x1080
SW=${RES%x*}               # screen width
SH=${RES#*x}               # screen height

# --- Margin opsional biar gak “nempel” pinggir (px) ---
GAP=8

# --- Ukuran grid dasar ---
HALF_W=$(( (SW - 3*GAP) / 2 ))
HALF_H=$(( (SH - 3*GAP) / 2 ))

THIRD_W=$(( (SW - 4*GAP) / 3 ))

# --- Posisi siap pakai ---
X_LEFT=$GAP
X_CENTER=$(( GAP*2 + THIRD_W ))
X_RIGHT=$(( GAP*3 + THIRD_W*2 ))

Y_TOP=$GAP
Y_MID=$(( GAP*2 + HALF_H ))
Y_BOTTOM=$(( GAP*3 + HALF_H*2 ))

# --- Window aktif ---
ACTIVE=":ACTIVE:"

# Helper wmctrl: -e gravity,x,y,width,height
move_resize() {
  local x=$1 y=$2 w=$3 h=$4
  wmctrl -r "$ACTIVE" -e "0,$x,$y,$w,$h"
}

case "$1" in
  left)    move_resize $X_LEFT $GAP $HALF_W $((SH - 2*GAP)) ;;
  right)   move_resize $((SW - GAP - HALF_W)) $GAP $HALF_W $((SH - 2*GAP)) ;;
  top)     move_resize $GAP $Y_TOP $((SW - 2*GAP)) $HALF_H ;;
  bottom)  move_resize $GAP $((SH - GAP - HALF_H)) $((SW - 2*GAP)) $HALF_H ;;
  tl)      move_resize $X_LEFT $Y_TOP $HALF_W $HALF_H ;;
  tr)      move_resize $((SW - GAP - HALF_W)) $Y_TOP $HALF_W $HALF_H ;;
  bl)      move_resize $X_LEFT $((SH - GAP - HALF_H)) $HALF_W $HALF_H ;;
  br)      move_resize $((SW - GAP - HALF_W)) $((SH - GAP - HALF_H)) $HALF_W $HALF_H ;;
  max)     wmctrl -r "$ACTIVE" -b add,maximized_vert,maximized_horz ;;
  center)  # letakkan jendela 2/3 lebar dan 2/3 tinggi di tengah
           local W=$((SW*2/3)); local H=$((SH*2/3))
           local X=$(((SW - W)/2)); local Y=$(((SH - H)/2))
           wmctrl -r "$ACTIVE" -b remove,maximized_vert,maximized_horz
           move_resize $X $Y $W $H
           ;;
  third-left)   move_resize $X_LEFT   $GAP $THIRD_W $((SH - 2*GAP)) ;;
  third-center) move_resize $X_CENTER $GAP $THIRD_W $((SH - 2*GAP)) ;;
  third-right)  move_resize $X_RIGHT  $GAP $THIRD_W $((SH - 2*GAP)) ;;
  *)
    echo "Usage: $(basename "$0") {left|right|top|bottom|tl|tr|bl|br|max|center|third-left|third-center|third-right}"
    exit 1
    ;;
esac
```

**Pasang shortcut di LXQt:**

* Buka **LXQt Configuration Center → Shortcut Keys → Add → Command**
* Command contoh:

  * Left half: `~/bin/tile.sh left`
  * Right half: `~/bin/tile.sh right`
  * Top half: `~/bin/tile.sh top`
  * Bottom half: `~/bin/tile.sh bottom`
  * Kuadran: `~/bin/tile.sh tl|tr|bl|br`
  * 1/3 kiri/tengah/kanan: `~/bin/tile.sh third-left|third-center|third-right`
* Ikat ke tombol yang kamu suka (mis. `Super+Left`, `Super+Right`, dst).

> Catatan: Script ini mengandalkan resolusi **monitor utama**. Untuk multi-monitor canggih (mis. tile di monitor ke-2), bisa saya bikinkan versi yang mendeteksi monitor tempat jendela aktif berada.

---

# 2) Script set DPI cepat (`dpi-set.sh`)

Biar UI mengecil (lebih banyak aplikasi muat) tanpa ubah resolusi.

**Simpan sebagai `~/bin/dpi-set.sh` dan beri izin:**

```bash
nano ~/bin/dpi-set.sh
chmod +x ~/bin/dpi-set.sh
```

**Isi filenya:**

```bash
#!/usr/bin/env bash
# Usage: dpi-set.sh 80   (angka DPI, contoh 80/85/90/96)
set -e
DPI="$1"
if [ -z "$DPI" ]; then
  echo "Usage: $(basename "$0") <dpi_number>   e.g. 80"
  exit 1
fi

# buat/ubah ~/.Xresources
grep -q '^Xft.dpi:' ~/.Xresources 2>/dev/null \
  && sed -i "s/^Xft.dpi:.*/Xft.dpi: $DPI/" ~/.Xresources \
  || echo "Xft.dpi: $DPI" >> ~/.Xresources

# merge ke sesi X berjalan
xrdb -merge ~/.Xresources

# pastikan merge jalan saat login berikutnya
if ! grep -q 'xrdb -merge ~/.Xresources' ~/.xprofile 2>/dev/null; then
  echo 'xrdb -merge ~/.Xresources &' >> ~/.xprofile
fi

echo "✅ DPI di-set ke $DPI. Logout/login atau restart aplikasi agar semua UI ikut ter-update."
```

**Cara pakai cepat:**

```bash
~/bin/dpi-set.sh 85   # coba 85 dulu
# kalau kebesaran/kekecilan, ulangi: ~/bin/dpi-set.sh 80 atau 90
```

---

## Rekomendasi kombinasi awal

1. Set DPI ke 85:

```bash
~/bin/dpi-set.sh 85
```

2. Buat shortcut:

* `Super+Left`  → `~/bin/tile.sh left`
* `Super+Right` → `~/bin/tile.sh right`
* `Super+Up`    → `~/bin/tile.sh top`
* `Super+Down`  → `~/bin/tile.sh bottom`
* `Super+Alt+1/2/3` → `~/bin/tile.sh third-left|third-center|third-right`

Kalau kamu pakai **dua monitor** dan mau tile khusus monitor kedua, bilang ya—aku bikin versi yang otomatis mendeteksi jendela aktif berada di monitor mana lalu tile di monitor itu.
