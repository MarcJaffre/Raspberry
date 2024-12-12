---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
## <p align='center'> Installation Jellyfin </p>
### Bash Générique
```bash
clear;
curl -s https://repo.jellyfin.org/install-debuntu.sh | bash
```

### Hardware Acceleration
```
- drm
- opencl
- rkmpp
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

