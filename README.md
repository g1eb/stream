# 📹 video live stream with FFmpeg

## Instructions

Run `init_stream.sh` create an hsl stream using FFmpeg:

```console
./init_stream.sh -f 30 -s 1920x1080 -m 4000k -b 8000k -g 50 -t 4 -o stream.m3u8
```

Run a simple python based http server:

```console
python -m http.server .
```

Keep track of the file size, just in case:

```console
watch -n 1 du -sh /path/to/directory
```

## NGINX Settings:

```
location /stream {
  alias /path/to/stream/;

  types {
      application/vnd.apple.mpegurl m3u8;
      video/mp2t ts;
  }

  add_header Cache-Control no-cache;
  add_header Access-Control-Allow-Origin *;
}
```

## Dependencies

<a href="https://ffmpeg.org/" target="_blank">https://ffmpeg.org/</a>


