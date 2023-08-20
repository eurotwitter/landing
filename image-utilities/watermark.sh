#!/bin/bash

echo "watermarking"

# Check if the required number of arguments (3) are provided
if [ $# -ne 3 ]; then
  echo "Usage: $0 <input_image> <watermark_image> <output_image>"
  exit 1
fi

# Command-line arguments
input_image="$1"
watermark_image="$2"
output_image="$3"

# Define the position of the watermark (bottom left corner)
position="10,10"

# Use ImageMagick's composite command to add the watermark
composite -dissolve 100% -gravity SouthWest "$watermark_image" "$input_image" "$output_image"

echo "Watermark added to $output_image"

