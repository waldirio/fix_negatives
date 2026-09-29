#!/bin/bash

# I'm hoping to see files with the extension .tif
DIR="/path/to/the/folder/that/you/scanned/SCAN_NEGATIVES/"

# The folder that will be saved all the final pictures
FINAL_DIR="/path/to/the/output/folder"

# If the output folder is not around, it will be created
if [ ! -d $FINAL_DIR ]; then
  echo "Creating folder ..."
  mkdir $FINAL_DIR
fi

# Checking for the binary in question that will be used by this script
which magick &>/dev/null
if [ $? -ne 0 ]; then
  echo "Binary magick not found .., exiting ..."
  exit
fi

# Retrieving all the files from the source directory
ls -1 $DIR/*.tif* | while read b
do
  echo "$b"
  file_name=$(basename "$b")

  ## Copying
  cp -v "$b" $FINAL_DIR

  ## Layers
  magick identify "$FINAL_DIR/$file_name"
  # Assuming here that 0 is the index
  magick "$FINAL_DIR/$file_name[0]" "$FINAL_DIR/$file_name"
  magick identify "$FINAL_DIR/$file_name"

  ## Color Balance
  convert "$FINAL_DIR/$file_name" -modulate 100,70,100 "$FINAL_DIR/$file_name"

  ## Resize
  magick identify "$FINAL_DIR/$file_name" | grep -o "TIFF.*" | awk '{print $2}' | sed 's/x/ /g' | while read x y
  do
    echo "X: $x, Y: $y"
    if [ $x -gt $y ]; then
      echo "1200x"
      convert "$FINAL_DIR/$file_name" -resize 1200x "$FINAL_DIR/$file_name"
    else
      echo "x1200"
      convert "$FINAL_DIR/$file_name" -resize x1200 "$FINAL_DIR/$file_name"
    fi
  done

done
