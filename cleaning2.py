import glob
import cv2
import numpy as np

files1 = glob.glob("E:/CodeFunDo/SLP_final/*.png")
files2 = glob.glob("E:/CodeFunDo/TCHP_final/*.png")
files3 = glob.glob("E:/CodeFunDo/WC_final/*.png")
files4 = glob.glob("E:/CodeFunDo/WS_final/*.png")


for im in files4:
    img = cv2.imread(im)
    img = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    cv2.imwrite("E:/CodeFunDo/WS_BW/"+im[30:38]+".png",img)