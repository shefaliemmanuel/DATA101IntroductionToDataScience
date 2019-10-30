#Shefali Emmanuel
#HW10
#October 30,2019

#Use Numpy in Python, how to create and print a 2D array to simulate an 8x8 chess board? Use 0 for black cell and 1 for white.

import numpy as np

#option number 1
x = np.array([(0,1,0,1,0,1,0,1),(1,0,1,0,1,0,1,0),(0,1,0,1,0,1,0,1),(1,0,1,0,1,0,1,0),(0,1,0,1,0,1,0,1),(1,0,1,0,1,0,1,0),(0,1,0,1,0,1,0,1),(1,0,1,0,1,0,1,0)])

print("Array = ")
print(x)

#option number 2
x = np.zeros((8,8),dtype=int) #if you dont have the data type as an interger, it will print with .
x[1::2,::2]=1
x[::2,1::2]=1

print("Array = ")
print(x)

#option number 3
x = np.ones((8,8),dtype=int) #if you dont have the data type as an interger, it will print with .

x[::2,1::2]=0
x[1::2,::2]=0

print("Array = ")
print(x)