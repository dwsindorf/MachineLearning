#!/usr/bin/env bash

#IMAGE="/home/dean/data/voc-data/small/train/images/2007_000256.jpg"
IMAGE1="/home/dean/data/VOCdevkit/VOC2007/JPEGImages/000004.jpg"
#IMAGE2="/home/dean/data/VOCdevkit/VOC2007/JPEGImages/000002.jpg"
#IMAGE3="/home/dean/data/VOCdevkit/VOC2007/JPEGImages/000007.jpg"

VOC_IMAGES=/home/dean/data/VOCdevkit/VOC2007/voc_100.list
MY_IMAGES=/home/dean/data/myimages.list

export PYTHONPATH=python

echo ${IMAGE1} > test.list
#echo ${IMAGE2} >> test.list
#echo ${IMAGE3} >> test.list


IMAGE_LIST=test.list
IMAGE_LIST=${VOC_IMAGES}

mkdir -p images
rm -f images/*

MODEL=models/VGGNet/VOC0712/SSD_300x300/deploy.prototxt
#WEIGHTS=models/VGGNet/VOC0712/SSD_300x300/VGG_VOC0712_SSD_300x300_iter_120000.caffemodel
WEIGHTS=models/VGGNet/VOC0712/SSD_300x300/VGG_VOC0712_SSD_300x300_iter_10000.caffemodel

time build/examples/ssd/ssd_detect.bin -confidence_threshold 0.6 -out_file test.out ${MODEL} ${WEIGHTS} ${IMAGE_LIST}

LABELS=data/VOC0712/labelmap_voc.prototxt

python examples/ssd/plot_detections.py --labelmap-file ${LABELS} --save-dir images test.out /

eog images/*
