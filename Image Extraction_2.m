%Extracting raw Images One by One
clc;
clear all;
close all;
image=load('E:\Dissertation\Control db\Farsiu_Ophthalmology_2013_Control_Subject_1051.mat');
img=image.images;
a=mat2gray(img);
imge=a(:,:,50);
imshow(imge)
imwrite(imge,'E:\Dissertation\Control db\Control_1050.jpg');
