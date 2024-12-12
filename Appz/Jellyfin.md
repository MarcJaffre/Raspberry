---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
## <p align='center'> Installation Jellyfin </p>
### Bash Générique
```bash
clear;
curl -s https://repo.jellyfin.org/install-debuntu.sh | bash
```

### Hardware Acceleration
```
["drm", "opencl", "rkmpp"]
```

### Encodage
```
- aac
- ac3
- alac
- dca
- flac
- h264_rkmpp
- h264_v4l2m2m
- hevc_rkmpp
- libfdk_aac
- libmp3lame
- libopus
- libsvtav1
- libvorbis
- libvpx
- libvpx-vp9
- libx264
- libx265
- mpeg4
- msmpeg4
- srt
- truehd
```


### Decodage
```
- ac3
- aac
- av1
- dca
- flac
- h264
- hevc
- libdav1d
- libvpx
- libvpx-vp9
- mpeg2video
- mpeg4
- msmpeg4
- vp8
- vp9
- mp3
- truehd

- av1_rkmpp
- h264_rkmpp
- hevc_rkmpp
- mpeg1_rkmpp
- mpeg2_rkmpp
- mpeg4_rkmpp
- vp8_rkmpp
- vp9_rkmpp
```

### filters
```
alphasrc
overlay_opencl
overlay_rkrga
scale_opencl
scale_rkrga
tonemap_opencl
vpp_rkrga
zscale


overlay_vaapi with option Action to take when encountering EOF from secondary input is not available
overlay_vulkan with option Action to take when encountering EOF from secondary input is not available
scale_cuda with option Output format (default "same")  is not available
tonemap_cuda with option GPU accelerated HDR to SDR tonemapping is not available

```

Filter:

[21:22:33] [WRN] [1] MediaBrowser.MediaEncoding.Encoder.MediaEncoder: Filter:

[21:22:33] [WRN] [1] MediaBrowser.MediaEncoding.Encoder.MediaEncoder: Filter: 

[21:22:33] [WRN] [1] MediaBrowser.MediaEncoding.Encoder.MediaEncoder: Filter: 

[21:22:33] [INF] [1] MediaBrowser.MediaEncoding.Encoder.MediaEncoder: Available hwaccel types: 

[21:32:27] [WRN] [49] Microsoft.AspNetCore.StaticFiles.StaticFileMiddleware: The WebRootPath was not found: /run/s6-rc:s6-rc-init:LCBdDJ/servicedirs/svc-jellyfin/wwwroot. Static files may be unavailable.

[21:32:28] [INF] [49] MediaBrowser.MediaEncoding.Encoder.MediaEncoder: Available decoders: ["libdav1d", "av1", "av1_rkmpp", "h264", "h264_rkmpp", "hevc", "hevc_rkmpp", "mpeg1_rkmpp", "mpeg2video", "mpeg2_rkmpp", "mpeg4", "mpeg4_rkmpp", "msmpeg4", "vp8", "vp8_rkmpp", "libvpx", "vp9", "vp9_rkmpp", "libvpx-vp9", "aac", "ac3", "dca", "flac", "mp3", "truehd"]

[21:32:28] [INF] [49] MediaBrowser.MediaEncoding.Encoder.MediaEncoder: Available encoders: ["libsvtav1", "libx264", "h264_v4l2m2m", "h264_rkmpp", "libx265", "hevc_rkmpp", "mpeg4", "msmpeg4", "libvpx", "libvpx-vp9", "aac", "libfdk_aac", "ac3", "alac", "dca", "flac", "libmp3lame", "libopus", "truehd", "libvorbis", "srt"]

[21:32:28] [INF] [49] MediaBrowser.MediaEncoding.Encoder.MediaEncoder: Available filters: ["overlay_opencl", "overlay_rkrga", "scale_opencl", "scale_rkrga", "tonemap_opencl", "vpp_rkrga", "zscale", "alphasrc"]

[21:32:28] [WRN] [49] MediaBrowser.MediaEncoding.Encoder.MediaEncoder: Filter: scale_cuda with option Output format (default "same") is not available

[21:32:28] [WRN] [49] MediaBrowser.MediaEncoding.Encoder.MediaEncoder: Filter: tonemap_cuda with option GPU accelerated HDR to SDR tonemapping is not available

[21:32:28] [WRN] [49] MediaBrowser.MediaEncoding.Encoder.MediaEncoder: Filter: overlay_vaapi with option Action to take when encountering EOF from secondary input is not available

[21:32:28] [WRN] [49] MediaBrowser.MediaEncoding.Encoder.MediaEncoder: Filter: overlay_vulkan with option Action to take when encountering EOF from secondary input is not available

[21:32:28] [INF] [49] MediaBrowser.MediaEncoding.Encoder.MediaEncoder: Available hwaccel ty
