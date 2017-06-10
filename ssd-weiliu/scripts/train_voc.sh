#!/usr/bin/env bash

cd ../
export PYTHONPATH=python

LOG=logs/voc_train.txt
exec &> >(tee "$LOG")
echo Logging output to "$LOG"

python examples/ssd/ssd_pascal.py

