
LABELS=data/VOC0712/labelmap_voc.prototxt
SAVEDIR=images

python examples/ssd/plot_detections.py --labelmap-file ${LABELS} --save-dir ${SAVEDIR} test.out /