#!/usr/bin/env bash

#IMAGE=data/dog.jpg
#IMAGE=/home/dean/data/voc-data/small/train/images/2007_000256.jpg
IMAGE=/home/dean/data/stop-yield-data/test/stopsign_00001.jpg
#IMAGE=/home/dean/data/stop-yield-data/images/stopsign/003.jpg

WEIGHTS=weights/yolo-2class.3000.weights
#WEIGHTS=weights/yolo-2class-1000-dn448.weights

CFG=cfg/yolo-2class.cfg

darknet detector test data/signs.data ${CFG} ${WEIGHTS} ${IMAGE} -thresh 0.1