#!/bin/zsh

input=$1

output=$(dirname ${input})/anime.gif
tmp=$(dirname ${input})/tmp.gif
echo $output


ffmpeg -i $input -vf fps=30,scale=640:-1:flags=lanczos,palettegen palette.png
ffmpeg -i $input -i palette.png -filter_complex "fps=30,scale=640:-1:flags=lanczos[x];[x][1:v]paletteuse" $tmp

gifsicle -O3 --colors=128 --lossy=30 $tmp -o $output

rm -rf palette.png
rm -rf $tmp
