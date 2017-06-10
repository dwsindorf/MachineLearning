#!/usr/bin/env bash

LOG=logs/signs_tiny_train.txt
exec &> >(tee "$LOG")
echo Logging output to "$LOG"

WEIGHTS=weights/tiny-yolo-12.weights

time darknet detector train data/signs.data cfg/tiny-yolo-signs.cfg ${WEIGHTS}
