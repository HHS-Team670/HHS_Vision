#!/bin/sh
python /home/PowerCuber.py &
gst-launch-1.0 v4l2src device=/dev/video0 ! video/x-raw, width=320, height=240, framerate=30/1 ! jpegenc ! rtpjpegpay ! udpsink host=LAPTOP-LU3PAHOV.local port=1181 &
gst-launch-1.0 v4l2src device=/dev/video1 ! video/x-raw, width=320, height=240, framerate=30/1 ! jpegenc ! rtpjpegpay ! udpsink host=LAPTOP-LU3PAHOV.local port=1182 &
