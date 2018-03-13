import cv2
import numpy as np
from networktables import NetworkTables

def show_webcam():
        ip = "roboRIO-670-frc.local"
        NetworkTables.initialize(server=ip)
        table = NetworkTables.getTable("raspberryPi")
        lower = np.array([19,96,0])
        upper = np.array([53,188,255])
        cam = cv2.VideoCapture(0)
        while True:
                ret_val, img = cam.read()
                maxX = 0
                maxY = 0
                maxW = 0
                maxH = 0
                ret_val, img = cam.read()
                threshed_img = cv2.inRange(cv2.cvtColor(img, cv2.COLOR_BGR2HSV), lower, upper)
                threshed_img = cv2.blur(threshed_img,(5,5))
                contours, hierarchy = cv2.findContours(threshed_img, cv2.RETR_TREE, cv2.CHAIN_APPROX_SIMPLE)
                for c in contours:
                        x, y, w, h = cv2.boundingRect(c)
                        if w*h > maxW*maxH:
                                maxW = w
                                maxH = h
                                maxX = x
                                maxY = y
                degreesPerPixel=-0.08765625
                targetX=320
                rectMidX=maxX+(maxW/2)
                rads = degreesPerPixel*(targetX - rectMidX)
                print(rads)
                table.putNumber('angleToPowerCube', rads)
                table.putNumber('x', maxX)
                table.putNumber('y', maxY)
                table.putNumber('w', maxW)
                table.putNumber('cubeWidth', maxH)
                cv2.rectangle(img, (maxX, maxY), (maxX+maxW, maxY+maxH), (0, 225, 0), 2)

def main():
        show_webcam()

if __name__ == '__main__':
        main()
