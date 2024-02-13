#!/bin/bash

# Display ASCII art when the script is invoked
cat << "EOF"

   __|  |  |  \ |   __|  __| __ __|
 \__ \  |  | .  | \__ \  _|     |
 ____/ \__/ _|\_| ____/ ___|   _|

EOF

# Default values for variables
FRAMERATE=30
VIDEO_SIZE="2560x1440"
MAXRATE="5000k"
BUFSIZE="10000k"
GOP=60
HLS_TIME=5
OUTPUT="stream.m3u8"

# Override defaults if arguments are provided
while getopts "f:s:m:b:g:t:o:" opt; do
  case $opt in
    f) FRAMERATE=$OPTARG ;;
    s) VIDEO_SIZE=$OPTARG ;;
    m) MAXRATE=$OPTARG ;;
    b) BUFSIZE=$OPTARG ;;
    g) GOP=$OPTARG ;;
    t) HLS_TIME=$OPTARG ;;
    o) OUTPUT=$OPTARG ;;
    \?) echo "Invalid option -$OPTARG" >&2 ;;
  esac
done

# Remove any files from the previous stream(s)
rm -rf stream*

# Run FFmpeg with the specified parameters
ffmpeg \
  -f avfoundation \
  -framerate "$FRAMERATE" \
  -video_size "$VIDEO_SIZE" \
  -i "0" \
  -r "$FRAMERATE" \
  -copyts -c:v libx264 \
  -preset veryfast \
  -maxrate "$MAXRATE" \
  -bufsize "$BUFSIZE" \
  -vf "format=yuv420p" \
  -g "$GOP" \
  -hls_time "$HLS_TIME" \
  -hls_playlist_type event \
  "$OUTPUT"
