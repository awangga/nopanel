Sip, aku bikinin versi **multi-monitor aware**: jendela akan ditile di **monitor tempat jendela aktif berada** (bukan selalu di primary).

---

## Script: `tile-smart.sh`

**Fungsi:** tile kiri/kanan/atas/bawah/kuadran/1⁄3, per-monitor otomatis.

**Dependensi (sekali pasang):**

```bash
sudo apt install wmctrl xdotool x11-utils
```

**Simpan & izinkan eksekusi:**

```bash
mkdir -p ~/bin
nano ~/bin/tile-smart.sh
chmod +x ~/bin/tile-smart.sh
```

**Isi file:**

```bash
#!/usr/bin/env bash
# Tiling jendela per-monitor (LXQt/X11) menggunakan xrandr + xdotool + wmctrl
# Pakai: tile-smart.sh left|right|top|bottom|tl|tr|bl|br|max|center|third-left|third-center|third-right

set -euo pipefail

ACTION="${1:-}"
[ -z "$ACTION" ] && { echo "Usage: $(basename "$0") {left|right|top|bottom|tl|tr|bl|br|max|center|third-left|third-center|third-right}"; exit 1; }

ACTIVE=":ACTIVE:"
GAP=8   # margin tepi (px). Ubah sesuai selera: 0–16 biasanya pas.

# --- Info jendela aktif ---
# xdotool export geometry dalam bentuk shell vars: X= Y= WIDTH= HEIGHT=
eval "$(xdotool getactivewindow getwindowgeometry --shell)"
WX="$X"; WY="$Y"; WW="$WIDTH"; WH="$HEIGHT"
CX=$(( WX + WW/2 ))   # center x
CY=$(( WY + WH/2 ))   # center y

# --- Ambil daftar monitor aktif & geometri mereka ---
# Format contoh baris xrandr: "HDMI-1 connected primary 2560x1440+0+0 ..."
mapfile -t MONS < <(xrandr --query | awk '/ connected/{print $1,$3,$4}' )

# Pilih monitor yang mengandung titik (CX,CY)
SEL_MON=""
SX=0; SY=0; SW=0; SH=0

for line in "${MONS[@]}"; do
  # Parsing bisa beda: ada yang "primary 2560x1440+0+0", ada yang langsung "1920x1080+2560+0"
  # Ambil token terakhir yang memuat WxH+X+Y
  GEO=$(awk '{print $NF}' <<<"$line")
  if [[ "$GEO" =~ ^([0-9]+)x([0-9]+)\+(-?[0-9]+)\+(-?[0-9]+)$ ]]; then
    W="${BASH_REMATCH[1]}"; H="${BASH_REMATCH[2]}"; X0="${BASH_REMATCH[3]}"; Y0="${BASH_REMATCH[4]}"
    X1=$(( X0 + W )); Y1=$(( Y0 + H ))
    if (( CX >= X0 && CX < X1 && CY >= Y0 && CY < Y1 )); then
      SEL_MON="$line"
      SX="$X0"; SY="$Y0"; SW="$W"; SH="$H"
      break
    fi
  fi
done

# Fallback: bila tak ketemu (misal window minimized), pilih monitor pertama bertanda geometry valid
if [ -z "$SEL_MON" ]; then
  for line in "${MONS[@]}"; do
    GEO=$(awk '{print $NF}' <<<"$line")
    if [[ "$GEO" =~ ^([0-9]+)x([0-9]+)\+(-?[0-9]+)\+(-?[0-9]+)$ ]]; then
      SW="${BASH_REMATCH[1]}"; SH="${BASH_REMATCH[2]}"; SX="${BASH_REMATCH[3]}"; SY="${BASH_REMATCH[4]}"
      SEL_MON="$line"
      break
    fi
  done
fi

[ -z "$SEL_MON" ] && { echo "Tidak dapat menentukan monitor aktif."; exit 2; }

# --- Hitung ukuran target relatif terhadap monitor terpilih ---
HALF_W=$(( (SW - 3*GAP) / 2 ))
HALF_H=$(( (SH - 3*GAP) / 2 ))
THIRD_W=$(( (SW - 4*GAP) / 3 ))

X_LEFT=$(( SX + GAP ))
X_CENTER=$(( SX + 2*GAP + THIRD_W ))
X_RIGHT=$(( SX + 3*GAP + 2*THIRD_W ))

Y_TOP=$(( SY + GAP ))
Y_MID=$(( SY + 2*GAP + HALF_H ))
Y_BOTTOM=$(( SY + 3*GAP + 2*HALF_H ))

# Helper: clear maximize lalu resize
move_resize () {
  local x="$1" y="$2" w="$3" h="$4"
  wmctrl -r "$ACTIVE" -b remove,maximized_vert,maximized_horz || true
  wmctrl -r "$ACTIVE" -e "0,$x,$y,$w,$h"
}

case "$ACTION" in
  left)        move_resize $X_LEFT $Y_TOP $HALF_W $((SH - 2*GAP)) ;;
  right)       move_resize $((SX + SW - GAP - HALF_W)) $Y_TOP $HALF_W $((SH - 2*GAP)) ;;
  top)         move_resize $X_LEFT $Y_TOP $((SW - 2*GAP)) $HALF_H ;;
  bottom)      move_resize $X_LEFT $((SY + SH - GAP - HALF_H)) $((SW - 2*GAP)) $HALF_H ;;
  tl)          move_resize $X_LEFT $Y_TOP $HALF_W $HALF_H ;;
  tr)          move_resize $((SX + SW - GAP - HALF_W)) $Y_TOP $HALF_W $HALF_H ;;
  bl)          move_resize $X_LEFT $((SY + SH - GAP - HALF_H)) $HALF_W $HALF_H ;;
  br)          move_resize $((SX + SW - GAP - HALF_W)) $((SY + SH - GAP - HALF_H)) $HALF_W $HALF_H ;;
  third-left)  move_resize $X_LEFT   $Y_TOP $THIRD_W $((SH - 2*GAP)) ;;
  third-center)move_resize $X_CENTER $Y_TOP $THIRD_W $((SH - 2*GAP)) ;;
  third-right) move_resize $X_RIGHT  $Y_TOP $THIRD_W $((SH - 2*GAP)) ;;
  center)
      W=$(( SW*2/3 )); H=$(( SH*2/3 ))
      X=$(( SX + (SW - W)/2 )); Y=$(( SY + (SH - H)/2 ))
      move_resize $X $Y $W $H ;;
  max)         wmctrl -r "$ACTIVE" -b add,maximized_vert,maximized_horz ;;
  *)           echo "Aksi tidak dikenal: $ACTION"; exit 3 ;;
esac
```

---

## Ikat ke Shortcut (perintah contoh)

Buka **LXQt Configuration Center → Shortcut Keys → Add → Command** lalu isi:

* `Super+Left`  → `~/bin/tile-smart.sh left`
* `Super+Right` → `~/bin/tile-smart.sh right`
* `Super+Up`    → `~/bin/tile-smart.sh top`
* `Super+Down`  → `~/bin/tile-smart.sh bottom`
* `Super+1`     → `~/bin/tile-smart.sh third-left`
* `Super+2`     → `~/bin/tile-smart.sh third-center`
* `Super+3`     → `~/bin/tile-smart.sh third-right`
* `Super+Enter` → `~/bin/tile-smart.sh center`
* `Super+M`     → `~/bin/tile-smart.sh max`

---

## Tips

* Ubah `GAP` di script (mis. 4, 8, 12) untuk selera padding.
* Jika kamu pakai scaling DPI (skrip `dpi-set.sh` kemarin), kombinasikan agar **lebih banyak aplikasi muat** sekaligus tetap rapi.
* Mau mode **grid 3×3** atau **snap 1/4 atas/bawah kiri/kanan** lebih lengkap? Bilang, nanti aku tambahkan presetnya.
