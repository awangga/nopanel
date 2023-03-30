# Tmux

Installation
```sh
sudo apt install tmux
```

## Using Tmux

Start session without name
```sh
tmux
tmux ls
tmux attach #
```
with session name
```sh
tmux new -s [name] 
tmux attach -t [name] 
```

## Tmux Command

Press Ctrl + B then :
* c Membuat jendela baru (dengan shell)
* w Memilih jendela dari list yang ada
* 0 Mengganti ke jendela 0
* , Mengganti nama jendela yang sedang berjalan
* % Membagi panel yang sedang berjalan secara horizontal menjadi dua panel
* " Membagi panel yang sedang berjalan secara vertical
* o Menuju ke panel berikutnya
* ; Berpindah antara panel yang sedang berjalan dan panel berikutnya
* x Menutup panel yang sedang berjalan