# OSPA metrics for basic vision tasks
This is MATLAB implementation of the OSPA(2) metric for multi-object tracking with bounding boxes. The metric is used in the following paper:

```
@ARTICLE{9976259,
  author={Nguyen, Tran Thien Dat and Rezatofighi, Hamid and Vo, Ba-Ngu and Vo, Ba-Tuong and Savarese, Silvio and Reid, Ian},
  journal={IEEE Transactions on Pattern Analysis and Machine Intelligence}, 
  title={How Trustworthy are Performance Evaluations for Basic Vision Tasks?}, 
  year={2023},
  volume={45},
  number={7},
  pages={8538-8552},
  doi={10.1109/TPAMI.2022.3227571}}
```
# Usages
Change the data paths in 'main_ospa2.m' according to your data paths. \
The file 'data/MOT17/MOT17-eval-seqmap.txt' contains the names of sequences need to be evaluated. Please create new seqmap file using format of this file for your dataset.  \
Run 'main_ospa2.m' to obtain the results. \
In default setting, OSPA(2) distance is computed using both IoU and GIoU base distances. You can set the flag 'flagGIoU' to select the base distance you want to use. If 'flagGIoU = false', IoU base distance is used (e.g., line 63, 66 in 'main_ospa2.m') . Otherwise, GIoU base distance is used. \
The results are shown in terms of  "OSPA score (%)" (algorithms with higher scores are better).
# Acknowledgment
These codes are based on OSPA(2) metric implementation for Euclidean base distance in MATLAB RFS tracking toolbox provided by Prof. Ba-Tuong Vo at http://ba-tuong.vo-au.com/codes.html.
# Contact
For any queries please contact me at tranthiendat.nguyen@gmail.com.\
Copyright (C) 2021, Tran Thien Dat Nguyen.
