v4l2-ctl -d /dev/video0 -c exposure_auto=1 -c exposure_absolute=300					
gst-launch-1.0 -v v4l2src device=/dev/video0 ! "video/x-raw,width=640,height=480,framerate=30/1" ! x264enc speed-preset=1 tune=zerolatency bitrate=2048 ! rtph264pay ! udpsink host=$1 port=5800 &

v4l2-ctl -d /dev/video1 -c exposure_auto=1 -c exposure_absolute=300					
gst-launch-1.0 -v v4l2src device=/dev/video1 ! "video/x-raw,width=320,height=240,framerate=30/1" ! x264enc speed-preset=1 tune=zerolatency bitrate=1024 ! rtph264pay ! udpsink host=$1 port=5801 &

v4l2-ctl -d /dev/video2 -c exposure_auto=1 -c exposure_absolute=300					
gst-launch-1.0 -v v4l2src device=/dev/video2 ! "video/x-raw,width=320,height=240,framerate=30/1" ! x264enc speed-preset=1 tune=zerolatency bitrate=1024 ! rtph264pay ! udpsink host=$1 port=5802 &					

v4l2-ctl -d /dev/video3 -c exposure_auto=1 -c exposure_absolute=300					
gst-launch-1.0 -v v4l2src device=/dev/video3 ! "video/x-raw,width=320,height=240,framerate=30/1" ! x264enc speed-preset=1 tune=zerolatency bitrate=1024 ! rtph264pay ! udpsink host=$1 port=5803 &		
