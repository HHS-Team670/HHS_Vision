import sys
import time
from networktables import NetworkTables

ip = "roboRIO-670-frc.local"
NetworkTables.initialize(server=ip)

table = NetworkTables.getTable("rpi")

lidarUnoVal=0

while True:
    table.putNumber('lidar_uno', lidarUnoVal)
