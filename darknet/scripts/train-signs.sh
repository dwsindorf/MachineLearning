#!/usr/bin/env bash

LOG=logs/signs_train.txt
exec &> >(tee "$LOG")
echo Logging output to "$LOG"

WEIGHTS=weights/darknet19_448.conv.23

#darknet yolo train cfg/yolo_2class_box11.cfg ${WEIGHTS}
darknet detector train data/signs.data cfg/yolo-2class.cfg ${WEIGHTS}

