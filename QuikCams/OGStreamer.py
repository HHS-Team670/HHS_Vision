import os
import RPi.GPIO as GPIO

class OGStreamer:

    def killStream(self):
        os.system('killall gst-launch-1.0')

    def startStream(self, cam, port):
        gst='gst-launch-1.0 v4l2src device=/dev/video'
        frames=' ! video/x-raw, width=320, height=240, framerate=30/1 ! jpegenc ! rtpjpegpay ! udpsink host=LAPTOP-LU3PAHOV.local port='
        cmd=gst+str(cam)+frames+str(port)
        os.system(cmd+'&')

GPIO.setmode(GPIO.BCM)
GPIO.setup(4, GPIO.IN, pull_up_down=GPIO.PUD_DOWN)

numOfCams=1
currentCam=0
maxCams=numOfCams-1

og = OGStreamer()

og.startStream(currentCam,1181)
os.system('echo Cam is running')
    
while 1==1:
    if GPIO.input(4):
        os.system('echo Cam is switching')
        og.killStream()
        if currentCam < maxCams:
            currentCam=currentCam+1
        else:
            currentCam=0
        og.startStream(currentCam,1181)
        os.system('Camera is now Cam' + str(currentCam))
