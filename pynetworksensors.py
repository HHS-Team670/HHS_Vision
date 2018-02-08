import sys
import time
from networktables import NetworkTables

ip = "10.6.70.2"
NetworkTables.initialize(server=ip)

table = NetworkTables.getTable("rpi")

luno = table.getAutoUpdateValue('lidar_uno', -1)

while True:
    print('lidar_uno:', luno.value)
    table.putNumber('lidar_uno', 24)
    time.sleep(1)
