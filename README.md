# OSPA metrics for basic vision tasks
This is MATLAB implementation of the OSPA(2) metric for multi-object tracking with bounding boxes. The metric is described in the following paper: \
@misc{RNVVSR2021VisionMetrics, \
     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; title={How Trustworthy are Performance Evaluations for Basic Vision Tasks?}, \
     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; author={Hamid Rezatofighi and Tran Thien Dat Nguyen and Ba-Ngu Vo and Ba-Tuong Vo and Silvio Savarese and Ian Reid}, \
     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; year={2021}, \
     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; eprint={2008.03533}, \
     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; archivePrefix={arXiv}, \
     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; primaryClass={cs.CV} \
} \
Link to the paper: https://arxiv.org/pdf/2008.03533.pdf \
OSPA metrics for detection and segmentation tasks will be released in subsequent version.
# Usages
Change the data paths in 'main_ospa2.m' according to your data paths. \
The file 'data/MOT17/MOT17-eval-seqmap.txt' contains the names of sequences need to be evaluated. \
Run 'main_ospa2.m' to obtain the results. \
In default setting, OSPA(2) distance is computed using both IoU and GIoU base distances. You can set the flag 'flagGIoU' to select the base distance you want to use. If 'flagGIoU = false', IoU base distance is used (e.g., line 63, 66 in 'main_ospa2.m') . Otherwise, GIoU base distance is used.
# Contact
For any queries please contact me at tranthiendat.nguyen@gmail.com.\
Copyright (C) 2021, Tran Thien Dat Nguyen.
