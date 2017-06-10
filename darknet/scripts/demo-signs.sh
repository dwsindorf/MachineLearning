#!/usr/bin/env bash

WEIGHTS=weights/yolo-2class.3000.weights
CFG=cfg/yolo-2class.cfg

darknet detector demo data/signs.data ${CFG} ${WEIGHTS} videos/yieldsigns2.mp4

