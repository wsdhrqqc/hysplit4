#!/bin/bash

for file in /Users/qingn/Hysplit4/working/input1/*.txt; do cp $file /Users/qingn/Hysplit4/working/CONTROL; /Users/qingn/Hysplit4/exec/hycs_std; done

