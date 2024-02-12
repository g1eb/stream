# video live stream using FFmpeg

## Instructions

Run FFmpeg to create an hsl stream:

```console
ffmpeg -f avfoundation -framerate 30 -video_size 2560x1440 -i "0" -r 30 -copyts -c:v libx264 -preset veryfast -maxrate 5000k -bufsize 10000k -vf "format=yuv420p" -g 60 -hls_time 5 -hls_playlist_type event stream.m3u8
```

Run a simple python based http server:

```console
python -m http.server .
```

Keep track of the file size, just in case:

```console
watch -n 1 du -sh /path/to/directory
```

## Dependencies

<a href="https://ffmpeg.org/" target="_blank">https://ffmpeg.org/</a>


