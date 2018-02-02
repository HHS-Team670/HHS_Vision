#!/bin/sh
# usage: ./runMJPG.sh <camera> <drivestation IP or hostname>

gst-launch-1.0 v4l2src device=/dev/video$1 ! video/x-raw, width=320, height=240, framerate=30/1 ! jpegenc ! rtpjpegpay ! udpsink host=$2 port=1181
