#!/usr/bin/env bash

# note: had to chage hard-coded path to 2007_test.txt in yolo.c

#darknet yolo valid cfg/yolo-voc.2.0.test.cfg weights/yolo-voc-trained-1000.weights
#WEIGHTS=weights/yolo-2class-1000-dn448.weights
WEIGHTS=weights/yolo-2class.3000.weights
CFG=cfg/yolo-2class.cfg
TEST=/home/dean/data/stop-yield-data/train.list

darknet detector recall ${TEST} ${CFG} ${WEIGHTS}
