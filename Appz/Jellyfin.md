---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
## <p align='center'> Installation Jellyfin </p>
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
### I. Installation de Base
### Bash Générique
```bash
clear;
curl -s https://repo.jellyfin.org/install-debuntu.sh | bash
```

<br />

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
### II. Lecture

### A. Hardware Acceleration
```
- []  drm
- []  opencl
- [x] rkmpp
```

### A. Decodage
#### 1. Base
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
```
#### 2. Rockchip-MPP
```
- [-] h264_rkmpp
- [x] hevc_rkmpp
- [-] mpeg1_rkmpp
- [-] mpeg2_rkmpp
- [-] mpeg4_rkmpp
- [-] vp8_rkmpp
- [-] vp9_rkmpp
- [-] av1_rkmpp
```


<br />

### B. Encodage
#### 1. Base
```
- aac
- ac3
- alac
- dca
- flac

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

#### 2. Rockchip-MPP
```
- [-] h264_v4l2m2m
- [-] h264_rkmpp
- [-] hevc_rkmpp
```

<br />

### C. filters
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
