start cmd.exe @cmd /k "C:\gstreamer\1.0\x86_64\bin\gst-launch-1.0.exe -e -v udpsrc port=1181 ! application/x-rtp, encoding-name=JPEG, payload=26 ! rtpjpegdepay ! jpegdec ! autovideosink"
