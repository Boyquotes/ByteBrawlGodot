readonly MARGIN_X=6
readonly MARING_Y=4
readonly SIZE_X=28
readonly SIZE_Y=30

 for y in {0..2}; do
  for x in {0..14}; do
    index=$((y*15+x+1))
    position="$(((SIZE_X*x)+MARGIN_X))+$(((SIZE_Y*y)+MARING_Y))"
    echo "${position} ${index}"
    magick icons.jpg -crop ${SIZE_X}x${SIZE_Y}+${position} icons/icon_${index}.jpg
  done
done


# magick icons.jpg -crop 28x30+6+4 img.jpg
