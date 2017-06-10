#!/usr/bin/env bash

cd ../
ALL_IMAGES=/home/dean/data/frc-robotics/BallToteData/toteball_images.list

export PYTHONPATH=python

IMAGE_LIST=${ALL_IMAGES}

mkdir -p images
rm -f images/*

MODEL=models/VGGNet/TOTEBALL/SSD_300x300/deploy.prototxt
WEIGHTS=models/VGGNet/TOTEBALL/SSD_300x300/VGG_TOTEBALL_SSD_300x300_iter_1502.caffemodel

time build/examples/ssd/ssd_detect.bin -confidence_threshold 0.6 -out_file test.out ${MODEL} ${WEIGHTS} ${IMAGE_LIST}

LABELS=data/TOTEBALL/labelmap_toteball.prototxt

python examples/ssd/plot_detections.py --labelmap-file ${LABELS} --save-dir images test.out /

eog images/*
