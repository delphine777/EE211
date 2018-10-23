# -*- coding: utf-8 -*-
import os
import numpy as np
import matplotlib.image as mpimg
from matplotlib import pyplot as plt


plt.close("all")
os.chdir('E:\\Dropbox\\MobileProjects\\211A\\HW\\HW01')


"""Reading images"""
def readpgm(name):
    with open(name) as f:
         lines = f.readlines()
    # Ignores commented lines
    for l in list(lines):
            if l[0] == '#':
                lines.remove(l)
    # Makes sure it is ASCII format (P2)
    assert lines[0].strip() == 'P2' 
    # Converts data to a list of integers
    data = []
    for line in lines[1:]:
        data.extend([int(c) for c in line.split()])
    return (np.array(data[3:]),(data[1],data[0]),data[2])

img0 = readpgm('Test_Image.pgm')
img = np.reshape(img0[0],img0[1])


""" Define convolution """


def myconvol(imag,kern):  
    
    #flip the images boundaries
    imag_big_up_dn  = np.concatenate( ( np.fliplr(np.flipud(imag)) ,np.flipud(imag)   , np.fliplr( np.flipud(imag)) )    ,1)
    imag_big_mid = np.concatenate( ((np.fliplr(imag)), imag ,(np.fliplr(imag))  ) , 1)
    imag_big = np.concatenate((imag_big_up_dn,imag_big_mid,imag_big_up_dn),0)

    imag_temp_len_0 = imag.shape[0] + kern.shape[0]-1
    imag_temp_len_1 = imag.shape[1] + kern.shape[1]-1
    imag_temp = np.zeros((imag_temp_len_0,imag_temp_len_1))
    
    start_0 = int( imag.shape[0] - kern.shape[0]/2 +1/2)
    start_1 = int( imag.shape[1] - kern.shape[1]/2 +1/2)
    end_0   = int( 2*imag.shape[0] + kern.shape[0]/2 -3/2 +1)
    end_1   = int( 2*imag.shape[1] + kern.shape[1]/2 -3/2 +1)
    imag_temp[:,:] = imag_big[ start_0:end_0 , start_1:end_1]    

    imag_new =  np.zeros((imag.shape[0],imag.shape[1]))


    for i in range (imag.shape[0]):
        for j in range (imag.shape[1]):
            for k in range(kern.shape[0]):
                for l in range(kern.shape[1]):
                    imag_new[i][j] = imag_temp[i+k][j+l] * kern[k][l] +imag_new[i][j]         

    return( imag_new )



""" Define Gaussian Kernel """

def mygaussiankern(sigma):
    
    coef = 1/(2*np.pi* sigma**2)
    size = sigma*3
    size = int(size)
    x, y = np.mgrid[-size:size+1, -size:size+1]
    kern = np.exp(-(x**2+y**2)/  (2*float(sigma**2)) ) *coef
        
    return (kern)
    
    
    


""" Design filters """

fil_mean = np.array([[1,1,1],[1,1,1],[1,1,1]])/9

fil_hp = np.array([[-1,-1,-1],[-1,8,-1],[-1,-1,-1]])/9



# Sobel
fil_sol_x = np.array([[-1, 0, 1],[-2,0,2],[-1,0,1]])
fil_sol_y = np.array([[-1,-2,-1],[ 0,0,0],[ 1,2,1]])


# Gaussian

fil_gau_1  = mygaussiankern(1)
fil_gau_5  = mygaussiankern(5)
fil_gau_15 = mygaussiankern(15)


""" Apply filters and saving files"""
os.chdir('E:\\Dropbox\\MobileProjects\\211A\\HW\\HW01\\Output')

print("Start convoulution\n")




mpimg.imsave('01_Original.png', img ,cmap='gray')

img_mean  = myconvol(img, fil_mean  )
mpimg.imsave('02-1_mean.png', img_mean ,cmap='gray')
img_hp    = myconvol(img, fil_hp    )
mpimg.imsave('02-2_high pass.png', img_hp ,cmap='gray')


img_sol_x = myconvol(img, fil_sol_x )
mpimg.imsave('03-1 Sobel-x.png', img_sol_x ,cmap='gray')
img_sol_y = myconvol(img, fil_sol_y )
mpimg.imsave('03-2 Sobel-y.png', img_sol_y ,cmap='gray')


print("Start doing gau parts")

img_gau_1  =  myconvol(img, fil_gau_1 )
mpimg.imsave('04-1 Gaussian sigma_1.png', img_gau_1 ,cmap='gray')

img_gau_5  =  myconvol(img, fil_gau_5 )
mpimg.imsave('04-2 Gaussian sigma_5.png', img_gau_5 ,cmap='gray')

img_gau_15 =  myconvol(img, fil_gau_15 )
mpimg.imsave('04-3 Gaussian sigma_15.png', img_gau_15 ,cmap='gray')


print("completed")

