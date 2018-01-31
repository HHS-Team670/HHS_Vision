C:\gstreamer\1.0\x86_64\bin\gst-launch-1.0.exe -e -v udpsrc port=5001 ! application/x-rtp, encoding-name=JPEG, payload=26 ! rtpjpegdepay ! jpegdec ! autovideosink

 gst-launch-1.0 -v v4l2src ! "image/jpeg,width=320,height=180,framerate=30/1" ! rtpjpegpay ! udpsink host=10.0.0.7 port=5001