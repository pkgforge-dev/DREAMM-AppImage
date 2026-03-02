#!/bin/sh

set -eu

ARCH=$(uname -m)
export ARCH
export OUTPATH=./dist
export ADD_HOOKS="self-updater.bg.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"

# Deploy dependencies
quick-sharun ./AppDir/bin/dreamm \
/usr/lib/alsa-lib/libasound_module_pcm_alsa_dsp.so \
/usr/lib/alsa-lib/libasound_module_pcm_jack.so \
/usr/lib/alsa-lib/libasound_module_pcm_oss.so \
/usr/lib/alsa-lib/libasound_module_pcm_pipewire.so \
/usr/lib/alsa-lib/libasound_module_pcm_speex.so \
/usr/lib/alsa-lib/libasound_module_pcm_upmix.so \
/usr/lib/alsa-lib/libasound_module_pcm_usb_stream.so \
/usr/lib/alsa-lib/libasound_module_pcm_vdownmix.so

# Additional changes can be done in between here

# Turn AppDir into AppImage
quick-sharun --make-appimage

# Test the app for 12 seconds, if the test fails due to the app
# having issues running in the CI use --simple-test instead
#quick-sharun --simple-test ./dist/*.AppImage
