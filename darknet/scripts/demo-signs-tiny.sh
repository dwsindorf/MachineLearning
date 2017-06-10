#!/usr/bin/env bash

WEIGHTS=weights/yolo-tiny-2class.1000.weights
#WEIGHTS=output/tiny-yolo-signs_900.weights
CFG=cfg/tiny-yolo-signs.cfg
VIDEO=videos/train.list

darknet detector demo data/signs.data ${CFG} ${WEIGHTS} videos/yieldsigns2.mp4

