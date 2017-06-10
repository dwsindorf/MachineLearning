#!/usr/bin/env bash

#darknet yolo demo cfg/yolo_2class_box11.cfg  weights/yolo_2class_box11_3000.weights data/YOLO_DEMO_Yield_Sign.mp4

#darknet yolo demo -thresh 0.3 cfg/yolo-voc.2.0.cfg weights/yolo-voc_final.weights data/cartest2.mp4
darknet yolo demo -thresh 0.3 cfg/tiny-yolo-voc.cfg weights/tiny-yolo-voc.weights data/cartest2.mp4


