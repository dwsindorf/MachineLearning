#!/usr/bin/env bash

#IMAGE=data/dog.jpg
#IMAGE=/home/dean/data/voc-data/small/train/images/2007_000256.jpg
IMAGE=/home/dean/AI/darknet/VOCdevkit/VOC2007/JPEGImages/000230.jpg

#WEIGHTS=weights/yolo-voc-trained-1000.weights
WEIGHTS=output/yolo-voc.backup

CFG=cfg/yolo-voc.2.0.test.cfg

darknet detector test cfg/voc.data ${CFG} ${WEIGHTS} ${IMAGE} -thresh 0.25