#!/usr/bin/env bash

VIDEO=/home/dean/AI/ssd-weiliu/examples/videos/ILSVRC2015_train_00755001.mp4

MODEL=models/VGGNet/VOC0712/SSD_300x300/deploy.prototxt
WEIGHTS=models/VGGNet/VOC0712/SSD_300x300/VGG_VOC0712_SSD_300x300_iter_120000.caffemodel

# get an error when tryng to open mp4 file from c++

#time build/examples/ssd/ssd_detect.bin -confidence_threshold 0.6 -file_type video ${MODEL} ${WEIGHTS} ${VIDEO}

# but python based hard-coded example works
 python examples/ssd/ssd_pascal_video.py 
