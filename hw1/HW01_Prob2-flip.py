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


""" Define Gaussian Kernels"""

def mygaussiankern(sigma):
    
    coef = 1/(2*np.pi* sigma**2)
    size = sigma*3
    size = int(size)
    x, y = np.mgrid[-size:size+1, -size:size+1]
    kern = np.exp(-(x**2+y**2)/  (2*float(sigma**2)) ) *coef
    
    return (kern)
    
def mygau_range(sigma):
    
    coef = 1/(2*np.pi* sigma**2)
    x = np.linspace(-127,127,255)
    gau_range = np.exp(-x**2/  (2*float(sigma**2)) ) *coef
    
    return (gau_range)    

""" Define convolution """

def mybfconvol(imag,kern,gau_range):

    #flip the image boundaries
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
        print(i/imag.shape[0]*100,"/100")
        for j in range (imag.shape[1]):
            for k in range(kern.shape[0]):
                for l in range(kern.shape[1]):
                    int_dif = int( np.absolute(kern[k][l]-imag_temp[i+k][j+l])  )-1
                    imag_new[i][j] = imag_temp[i+k][j+l] * kern[k][l]* gau_range[int_dif] +imag_new[i][j]

    return( imag_new )



""" Apply filters and saving files"""
os.chdir('E:\\Dropbox\\MobileProjects\\211A\\HW\\HW01\\Output\\BF')

print("Start convoulutions\n")


sigma_s =1.0

sigma_r =0.1
fil_gau   = mygaussiankern(sigma_s)
gau_range = mygau_range(sigma_r)
print("sigma_s =",sigma_s,"sigma_r =",sigma_r)
img_gauBF =  mybfconvol(img, fil_gau,gau_range )
mpimg.imsave('BF_s_%s_r_%s.png' %(sigma_s,sigma_r), img_gauBF ,cmap='gray')
print("Done")

sigma_r =0.3
fil_gau   = mygaussiankern(sigma_s)
gau_range = mygau_range(sigma_r)
print("sigma_s =",sigma_s,"sigma_r =",sigma_r)
img_gauBF =  mybfconvol(img, fil_gau,gau_range )
mpimg.imsave('BF_s_%s_r_%s.png' %(sigma_s,sigma_r), img_gauBF ,cmap='gray')
print("Done")

sigma_r =10.0
fil_gau   = mygaussiankern(sigma_s)
gau_range = mygau_range(sigma_r)
print("sigma_s =",sigma_s,"sigma_r =",sigma_r)
img_gauBF =  mybfconvol(img, fil_gau,gau_range )
mpimg.imsave('BF_s_%s_r_%s.png' %(sigma_s,sigma_r), img_gauBF ,cmap='gray')
print("Done")


sigma_s =3.0

sigma_r =0.1
fil_gau   = mygaussiankern(sigma_s)
gau_range = mygau_range(sigma_r)
print("sigma_s =",sigma_s,"sigma_r =",sigma_r)
img_gauBF =  mybfconvol(img, fil_gau,gau_range )
mpimg.imsave('BF_s_%s_r_%s.png' %(sigma_s,sigma_r), img_gauBF ,cmap='gray')
print("Done")

sigma_r =0.3
fil_gau   = mygaussiankern(sigma_s)
gau_range = mygau_range(sigma_r)
print("sigma_s =",sigma_s,"sigma_r =",sigma_r)
img_gauBF =  mybfconvol(img, fil_gau,gau_range )
mpimg.imsave('BF_s_%s_r_%s.png' %(sigma_s,sigma_r), img_gauBF ,cmap='gray')
print("Done")

sigma_r =10.0
fil_gau   = mygaussiankern(sigma_s)
gau_range = mygau_range(sigma_r)
print("sigma_s =",sigma_s,"sigma_r =",sigma_r)
img_gauBF =  mybfconvol(img, fil_gau,gau_range )
mpimg.imsave('BF_s_%s_r_%s.png' %(sigma_s,sigma_r), img_gauBF ,cmap='gray')
print("Done")



sigma_s =25.0

sigma_r =0.1
fil_gau   = mygaussiankern(sigma_s)
gau_range = mygau_range(sigma_r)
print("sigma_s =",sigma_s,"sigma_r =",sigma_r)
img_gauBF =  mybfconvol(img, fil_gau,gau_range )
mpimg.imsave('BF_s_%s_r_%s.png' %(sigma_s,sigma_r), img_gauBF ,cmap='gray')
print("Done")

sigma_r =0.3
fil_gau   = mygaussiankern(sigma_s)
gau_range = mygau_range(sigma_r)
print("sigma_s =",sigma_s,"sigma_r =",sigma_r)
img_gauBF =  mybfconvol(img, fil_gau,gau_range )
mpimg.imsave('BF_s_%s_r_%s.png' %(sigma_s,sigma_r), img_gauBF ,cmap='gray')
print("Done")

sigma_r =10.0
fil_gau   = mygaussiankern(sigma_s)
gau_range = mygau_range(sigma_r)
print("sigma_s =",sigma_s,"sigma_r =",sigma_r)
img_gauBF =  mybfconvol(img, fil_gau,gau_range )
mpimg.imsave('BF_s_%s_r_%s.png' %(sigma_s,sigma_r), img_gauBF ,cmap='gray')
print("Done")




