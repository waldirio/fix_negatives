# fix_negatives

This script will help with the processing of many `TIFF` files in a single shot.

Basically, you define some variables, as below
```
# I'm hoping to see files with the extension .tif
DIR="/path/to/the/folder/that/you/scanned/SCAN_NEGATIVES/"

# The folder that will be saved all the final pictures
FINAL_DIR="/path/to/the/output/folder"
```

Once you have it, just execute the script, and the files will be processed properly. In the end, you will have:
- An output file with a single channel
- An output file with the color balance adjusted (less red)
- An file that was resized, keeping 1200x or x1200, based on the picture dimentions


I hope you enjoy it!<br>
Waldirio