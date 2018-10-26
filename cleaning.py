import glob
import os

files1 = glob.glob("E:/CodeFunDo/SLP_Extracted/*.png")
files2 = glob.glob("E:/CodeFunDo/TCHP_Extracted/*.png")
files3 = glob.glob("E:/CodeFunDo/WC_Extracted/*.png")
files4 = glob.glob("E:/CodeFunDo/WS_Extracted/*.png")

#print(len(files1))
#print(len(files2))
#print(len(files3))

required = []
for i in range(20100101,20131231+1):
    #print(i)
    flag= 0
    for j in range(len(files1)):
        if files1[j].__contains__(str(i)):
            flag = 1
            break
    if flag == 1:
        flag=0
        for j in range(len(files2)):
            if files2[j].__contains__(str(i)):
                flag=1
                break
        if flag==1:
            #print("Yes")
            flag=0
            for j in range(len(files3)):
                if files3[j].__contains__(str(i)):
                    flag=1
                    break
            if flag==1:
                flag=0
                for j in range(len(files4)):
                        if files4[j].__contains__(str(i)):
                            flag=1
                            break
                if flag==1:
                    required.append(i)

#print(len(required))

#cnt=0

#for i in range(len(files1)):
#    delete = int(files1[i][27:35])
#    if required.__contains__(delete)==0:
#        os.remove(files1[i])
        
#for i in range(len(files2)):
#    if files2[i][28]=='t':
#        delete = int(files2[i][32:40])
#    else:
#        delete = int(files2[i][28:36])
#    if required.__contains__(delete)==0:
#        os.remove(files2[i])

#for i in range(len(files3)):
#    delete = int(files3[i][33:41])
#    if required.__contains__(delete)==0:
#        os.remove(files3[i])
#
#for i in range(len(files4)):
#    delete = int(files4[i][33:41])
#    if required.__contains__(delete)==0:
#        os.remove(files4[i])
#    


text = ""
for i in required:
    text = text + str(i) + ','

text = text[:len(text)-2]

f=open('label.txt','w+')

f.write(text)

f.close()