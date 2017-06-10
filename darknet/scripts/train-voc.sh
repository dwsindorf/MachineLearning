#!/usr/bin/env bash

LOG=logs/voc_train2.txt
exec &> >(tee "$LOG")
echo Logging output to "$LOG"

#darknet detector train cfg/voc.data cfg/yolo-voc.2.0.train.cfg darknet19_448.conv.23
#darknet detector train cfg/voc.data cfg/yolo-voc.2.0.train.cfg weights/yolo-voc-trained-1000.weights
darknet detector train cfg/voc.data cfg/yolo-voc.2.0.train.cfg weights/yolo-voc_final.weights