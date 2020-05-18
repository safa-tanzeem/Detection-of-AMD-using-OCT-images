 clc;
 clear all;
 close all;
 tic;
 cd('E:\Dissertation\Control db\images')
directory=dir;
for i=3:length(directory)
directory(i).name;
O_Img = imread(directory(i).name);
%O_Img = imread('E:\Dissertation\Control db\Control_1024.jpg');
%imshow(O_Img)
rect=[30 30 899 411];
P_Img=imcrop(O_Img,rect);
N_Img=double(imresize(P_Img,[256 512]));
%figure, imshow(N_Img)
sigma_hat  = stdEst(N_Img);
   nSig= sigma_hat;
    Par   = ParSet(nSig);   
    E_Img = WNNM_DeNoising( N_Img, Par );                                %WNNM denoisng function
    E_Img=uint8(E_Img);
    imwrite(E_Img,sprintf('control_%d.jpg',i-2));
end
    toc;