%Extracting Images from the files all at once
clc;
clear all;
close all;
tic;
 cd('E:\Dissertation\Control db\Files')
directory=dir;
for i=3:length(directory)
directory(i).name;
image=load(directory(i).name); 
img=image.images;
a=mat2gray(img); 
f=a(:,:,50);
imwrite(f,sprintf('%d.jpg',i-2));
end
toc
