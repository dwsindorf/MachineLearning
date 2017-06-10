#!/usr/bin/env bash

# note: had to chage hard-coded path to 2007_test.txt in yolo.c
#darknet yolo valid cfg/yolo-voc.2.0.test.cfg weights/yolo-voc-trained-1000.weights
darknet detector recall  cfg/voc.data cfg/yolo-voc.2.0.test.cfg weights/yolo-voc_final.weights
