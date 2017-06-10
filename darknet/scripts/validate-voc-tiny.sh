#!/usr/bin/env bash

# note: had to chage hard-coded path to 2007_test.txt in yolo.c

TEST=/home/dean/AI/darknet/data/2007_test.txt
CFG=cfg/tiny-yolo-voc.train.cfg

WEIGHTS=weights/tiny-yolo-voc.weights

#darknet yolo valid cfg/yolo-voc.2.0.test.cfg weights/yolo-voc-trained-1000.weights
#darknet detector recall  cfg/voc.data cfg/tiny-yolo-voc.train.cfg weights/tiny-yolo-voc.weights
darknet detector recall ${TEST} ${CFG} ${WEIGHTS}

