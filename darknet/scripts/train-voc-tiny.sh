#!/usr/bin/env bash

LOG=logs/voc_tiny_train.txt
exec &> >(tee "$LOG")
echo Logging output to "$LOG"

#darknet detector train cfg/voc.data cfg/yolo-voc.2.0.train.cfg darknet19_448.conv.23
darknet detector train cfg/voc.data cfg/tiny-yolo-voc.cfg weights/tiny-yolo-voc.weights
