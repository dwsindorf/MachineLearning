#!/usr/bin/env bash

# note: had to chage hard-coded path to 2007_test.txt in yolo.c
TEST=/home/dean/AI/darknet/balltote_train.txt
CFG=cfg/tiny-yolo-balltote-train.cfg
WEIGHTS=output/tiny-yolo-balltote-train_300.weights
#darknet detector recall cfg/balltote.data cfg/tiny-yolo-balltote-train.cfg output/tiny-yolo-balltote-train_300.weights
darknet detector recall ${TEST} ${CFG} ${WEIGHTS}

