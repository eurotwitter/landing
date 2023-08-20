# Windows with WSL Ubuntu

pick a folder and make two folders, original and watermarked

```bash
mkdir original
mkdir watermarked
```

Copy the watermark.sh script we made earlier to your folder.

add this script to the folder as watch_and_watermark.sh:
```bash
#!/bin/bash

# Check if the required number of arguments (4) are provided
if [ $# -ne 4 ]; then
  echo "Usage: $0 </path/to/watched_directory> </path/to/watermark.png> <ext> <poll duration>"
  exit 1
fi

# Directory to watch
WATCH_DIR=$1
WATERMARK=$2
EXT=$3
POLL_INTERVAL=$4

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
```
Make it executable:

```bash
chmod +x watch_and_watermark.sh
```

run it

```bash
./watch_and_watermark.sh /path/to/watched_directory /path/to/watermark.png ext poll_duration_in_seconds
```

As long as that is running it should move the image to original then watermark it.

# On Linux? inotify might be an option

First get inotify-tools

```bash
sudo apt install inotify-tools
```

change the script from above to use inotify instead:

```bash
    # Swap out the while loop
    inotifywait -e create -e moved_to --format "%w%f" "$WATCH_DIR" | while read NEW_FILE; do
        if [[ "$NEW_FILE" == "*.$EXT" ]]; then
         # switch the middle out too
        fi
    done


```
