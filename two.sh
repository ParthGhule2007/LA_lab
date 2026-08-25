#!/bin/bash
set -e

lab start cli-review

date
date +%R
file /home/student/zcat
wc /home/student/zcat
head -n 10 /home/student/zcat
tail -n 10 /home/student/zcat
tail -n 20 /home/student/zcat
date +%R

lab grade cli-review
lab finish cli-review
