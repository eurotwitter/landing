#!/bin/bash

# Check if the required number of arguments (4) are provided
if [ $# -ne 4 ]; then
  echo "Usage: $0 </path/to/watched_directory> </path/to/watermark.png> <ext> <poll duration>"
  exit 1
fi

echo "watch_and_watermark"

# Directory to watch
WATCH_DIR=$1
WATERMARK=$2
EXT=$3
POLL_INTERVAL=$4

# inotifywait has issues with the wsl
# while true; do
#     # Wait for new JPG files to be added
#     inotifywait -e create -e moved_to --format "%w%f" "$WATCH_DIR" | while read NEW_FILE; do
#         if [[ "$NEW_FILE" == *.jpg ]]; then
#             # Extract the filename without path
#             FILENAME=$(basename "$NEW_FILE")

#             # Move the original file to the 'original' directory
#             mv "$NEW_FILE" "$WATCH_DIR/original/$FILENAME"

#             # Watermark the image and save it in the 'watermarked' directory
#            ./watermark.sh "$WATCH_DIR/original/$FILENAME" "$WATERMARK" "$WATCH_DIR/watermarked/$FILENAME"
#         fi
#     done
# done


while true; do
    for NEW_FILE in "$WATCH_DIR"/*."$EXT"; do
        if [ -f "$NEW_FILE" ]; then
            # Check if the Zone.Identifier file exists
            ZONE_IDENTIFIER="$NEW_FILE:Zone.Identifier"
            
            if [ -f "$ZONE_IDENTIFIER" ]; then
                echo "removing windows zone identifier wart $ZONE_IDENTIFIER"
                # Remove the Zone.Identifier file
                rm "$ZONE_IDENTIFIER"
            fi

            # Extract the filename without path
            FILENAME=$(basename "$NEW_FILE")

            # Move the original file to the 'original' directory
            mv "$NEW_FILE" "$WATCH_DIR/original/$FILENAME"

            # Watermark the image and save it in the 'watermarked' directory
            ./watermark.sh "$WATCH_DIR/original/$FILENAME" "$WATERMARK" "$WATCH_DIR/watermarked/$FILENAME"
        fi
    done

    # Sleep for the polling interval
    sleep "$POLL_INTERVAL"
done