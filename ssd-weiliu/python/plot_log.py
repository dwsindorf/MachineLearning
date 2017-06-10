#!/usr/bin/env python

"""
Parse training log

Evolved from parse_log.sh
"""

import os
import re
import extract_seconds
import argparse
import csv
from collections import OrderedDict
import matplotlib.pyplot as plt
import pandas as pd

"""
sample output

I0608 10:52:30.927119 19222 solver.cpp:243] Iteration 330, loss = 7.29032
I0608 10:52:30.927280 19222 solver.cpp:259]     Train net output #0: mbox_loss = 6.79195 (* 1 = 6.79195 loss)
I0608 10:52:30.927317 19222 sgd_solver.cpp:138] Iteration 330, lr = 0.001
I0609 03:16:09.110113 23885 solver.cpp:546]     Test net output #0: detection_eval = 0.778522

"""

def parse_log(path_to_log):
    """Parse log file
    Returns (train_dict_list, test_dict_list)
    train_dict_list and test_dict_list are lists of dicts that define the table
    rows
    """
    regex_iteration = re.compile('Iteration (\d+), loss = ([\.\deE+-]+)')
    regex_train_output = re.compile('Train net output #(\d+): (\S+) = ([\.\deE+-]+)')
    regex_learning_rate = re.compile('lr = ([\.\deE+-]+)')
    regex_test_output = re.compile('Test net output #(\d+): detection_eval = ([\.\deE+-]+)')


    # Pick out lines of interest
    iteration = 0
    loss = -1
    learning_rate = 0.001
    train_dict_list = []
    train_row = None
    test_score=0.0

    logfile_year = extract_seconds.get_log_created_year(path_to_log)
    with open(path_to_log) as f:
        start_time = extract_seconds.get_start_time(f, logfile_year)
        last_time = start_time

        for line in f:
            iteration_match = regex_iteration.search(line)
            if iteration_match:
                iteration = float(iteration_match.group(1))
                loss = float(iteration_match.group(2))
            try:
                time = extract_seconds.extract_datetime_from_line(line,
                                                                  logfile_year)
            except:
                # Skip lines with bad formatting, for example when resuming solver
                continue

            # if it's another year
            if time.month < last_time.month:
                logfile_year += 1
                time = extract_seconds.extract_datetime_from_line(line, logfile_year)
            last_time = time

            seconds = (time - start_time).total_seconds()

            learning_rate_match = regex_learning_rate.search(line)

            if learning_rate_match:
                learning_rate = float(learning_rate_match.group(1))

            test_score_match = regex_test_output.search(line)
            if test_score_match:
                test_score = float(test_score_match.group(2))

            train_dict_list, train_row = parse_line_for_net_output(
                regex_train_output, train_row, train_dict_list,
                line, iteration, seconds, learning_rate,loss,test_score
            )


    return train_dict_list


def parse_line_for_net_output(regex_obj, row, row_dict_list,
                              line, iteration, seconds, learning_rate, loss,test_score):
    """Parse a single line for training or test output

    Returns a a tuple with (row_dict_list, row)
    row: may be either a new row or an augmented version of the current row
    row_dict_list: may be either the current row_dict_list or an augmented
    version of the current row_dict_list
    """

    output_match = regex_obj.search(line)
    if output_match:
        if not row or row['NumIters'] != iteration:
            # Push the last row and start a new one
            if row:
                # If we're on a new iteration, push the last row
                # This will probably only happen for the first row; otherwise
                # the full row checking logic below will push and clear full
                # rows
                row_dict_list.append(row)

            row = OrderedDict([
                ('NumIters', iteration),
                ('Seconds', seconds),
                ('LearningRate', learning_rate),
                ('Loss', loss),
                ('Accuracy', test_score),
            ])

        # output_num is not used; may be used in the future
        # output_num = output_match.group(1)
        output_name = output_match.group(2)
        output_val = output_match.group(3)
        row[output_name] = float(output_val)

    if row and len(row_dict_list) >= 1 and len(row) == len(row_dict_list[0]):
        # The row is full, based on the fact that it has the same number of
        # columns as the first row; append it to the list
        row_dict_list.append(row)
        row = None

    return row_dict_list, row


def fix_initial_nan_learning_rate(dict_list):
    """Correct initial value of learning rate
    Learning rate is normally not printed until after the initial test and
    training step, which means the initial testing and training rows have
    LearningRate = NaN. Fix this by copying over the LearningRate from the
    second row, if it exists.
    """
    if len(dict_list) > 1:
        dict_list[0]['LearningRate'] = dict_list[1]['LearningRate']

def plot(itrs,loss,mbox_loss,accuracy):
    fig, ax1 = plt.subplots()
   # ax1.plot(itrs, loss, mbox_loss)
    #plt.figure(figsize=(10, 8))
    ax1.plot(itrs, loss)
    ax1.plot(itrs, mbox_loss)

    plt.title('Training Plot', fontsize=20)
    ax1.set_xlabel('Iteration')
    ax1.set_ylabel('Loss')
    plt.grid(True)

    ax2 = ax1.twinx()
    ax2.set_ylim([0,1.0])
    ax2.plot(itrs, accuracy,'r')

    ax2.set_ylabel('Accuracy')


    ax1.legend(['Loss', 'mbox_loss'], loc='upper left')
    ax2.legend(['Accuracy'], loc='upper right')

    plt.show()

def plot_lists(dict_lists):
    loss=[]
    itrs=[]
    mbox_loss=[]
    accuracy=[]
    for index in range(len(dict_lists)):
        line = dict_lists[index]
        # print(line)
        itrs.append(line['NumIters'])
        loss.append(line['Loss'])
        mbox_loss.append(line['mbox_loss'])
        accuracy.append(line['Accuracy'])


    plot(itrs,loss,mbox_loss,accuracy)


def parse_args():
    description = ('Plot/Parse a faster-rcnn training log')
    parser = argparse.ArgumentParser(description=description)

    parser.add_argument('logfile_path',
                        help='Path to log file (required)')

    args = parser.parse_args()
    return args

Debug=False
if Debug == True:
    logfile_path='/home/dean/AI/ssd-weiliu/logs/voc_train.txt'
    dict_list = parse_log(logfile_path)
    plot_lists(dict_list)

def main():
    args = parse_args()
    logfile_path=args.logfile_path
    dict_list=[]
    dict_list = parse_log(logfile_path)

    plot_lists(dict_list)

if __name__ == '__main__':
    main()