#!/usr/bin/env bash

ROOT_DIR=.
#IMAGE=/home/dean/data/voc-data/small/train/images/2007_000256.jpg
IMAGE=${ROOT_DIR}/test.list
#FLAGS=-confidence_threshold 0.5 -out_file test.out

MODEL=${ROOT_DIR}/models/VGGNet/VOC0712/SSD_300x300/deploy.prototxt
WEIGHTS=${ROOT_DIR}/models/VGGNet/VOC0712/SSD_300x300/VGG_VOC0712_SSD_300x300_iter_120000.caffemodel


${ROOT_DIR}/build/examples/ssd/ssd_detect.bin -confidence_threshold 0.5 -out_file test.out ${MODEL} ${WEIGHTS} ${IMAGE}