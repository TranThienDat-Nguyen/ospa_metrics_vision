# OSPA metrics for basic vision tasks
This is MATLAB implementation of the OSPA(2) metric for multi-object tracking task with bounding boxes. The metric is described in the following paper: \
@misc{RNVVSR2021VisionMetrics, \
     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; title={How Trustworthy are Performance Evaluations for Basic Vision Tasks?}, \
     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; author={Hamid Rezatofighi and Tran Thien Dat Nguyen and Ba-Ngu Vo and Ba-Tuong Vo and Silvio Savarese and Ian Reid}, \
     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; year={2021}, \
     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; eprint={2008.03533}, \
     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; archivePrefix={arXiv}, \
     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; primaryClass={cs.CV} \
} \
OSPA metrics for detection and segmentation tasks will be released in subsequent version.
# Usages
Change the paths to your data in the file 'main.m'. \ 
Run the file 'main.m' to obtain the results. \
In default setting I compute the distance with both IoU and GIoU base distances, you can set the flag 'flagGIoU' to select which base distance you want to use. If 'flagGIoU = false', the metric use IoU base distance, otherwise, it uses GIoU base distance.
# Contact
For any queries please contact me at tranthiendat.nguyen@gmail.com.\
Copyright (C) 2021, Tran Thien Dat Nguyen.
