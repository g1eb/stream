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
MAXRATE="15M"
BUFSIZE="10M"
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
echo "Removing any old stream files.."
rm -rf stream*

# Run FFmpeg with the specified parameters
ffmpeg \
  -f avfoundation \
  -framerate "$FRAMERATE" \
  -video_size "$VIDEO_SIZE" \
  -i "0" \
  -r "$FRAMERATE" \
  -copyts \
  -c:v h264 \
  -preset:v ultrafast \
  -maxrate "$MAXRATE" \
  -bufsize "$BUFSIZE" \
  -g "$GOP" \
  -hls_time "$HLS_TIME" \
  -hls_list_size 10 \
  -hls_playlist_type event \
  -thread_queue_size 32768 \
  "$OUTPUT"
