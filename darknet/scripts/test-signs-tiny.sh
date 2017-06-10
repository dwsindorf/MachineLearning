#!/usr/bin/env bash

IMAGE=/home/dean/data/stop-yield-data/test/stopsign_00001.jpg
#IMAGE=/home/dean/data/stop-yield-data/images/stopsign/003.jpg

WEIGHTS=weights/yolo-tiny-2class.1000.weights

CFG=cfg/tiny-yolo-signs.cfg

darknet detector test data/signs.data ${CFG} ${WEIGHTS} ${IMAGE}