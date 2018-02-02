#!/bin/sh
# usage: ./runMJPG.sh <drivestation IP or hostname>

terminal -e gst-launch-1.0 v4l2src device=/dev/video0 ! video/x-raw, width=320, height=240, framerate=30/1 ! jpegenc ! rtpjpegpay ! udpsink host=$1 port=1181
terminal -e gst-launch-1.0 v4l2src device=/dev/video1 ! video/x-raw, width=320, height=240, framerate=30/1 ! jpegenc ! rtpjpegpay ! udpsink host=$1 port=1182
