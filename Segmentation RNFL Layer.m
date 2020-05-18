%Segmentation of RNFL Layer
clear all;
clc;
image = imread ('E:\Dissertation\dementia db\De noised\AMDdn_1010.jpg'); %Input Image
g=adapthisteq(image); %Histogram Equalisation
select=uint8(imgaussfilt(image,0.1)); %Gaussian Filter
maxm = max(gray,[],2);
m = size(select);

 %Trellis   
 d =1; %distance
 num = ceil(m(1,2)/d); %Number of columns
 sel=medfilt2(select); %Median Filtering
 f_select = double(sel);
 trellis = int8(zeros(m));
 
 %Gradient of the image
     for i = 1:num
     for j = 1:m(1,1)-1
         trellis(j,i) = (f_select(j+1,i*d)-f_select(j,i*d));
     end
%    figure, imshow(trellis(:,i))
     end
%  figure, imshow(trellis)
 trellis(trellis<0)=0;
% figure, imshow(uint8(trellis))
%  figure
 imshow(select)
 
%peak finding algorithm
% locs=zeros(20,num);
% rnfl=zeros(num,1);
new=uint8(zeros(m));
% figure
for i = 1:num
locs=[0;0];
[peaks,locations] = findpeaks(abs(double(trellis(:,i))),'MinPeakHeight',10);
%pk= sort(peaks,'descend');

index(1:2) =peaks(1:2);
%find(peaks==pk(1) | peaks==pk(2)) | peaks==pk(3));
w= sort(index,'descend');

l=find(index == w(1));

loc = locations(l) %index(k));
x = repelem(i*d,1);
y = loc;

% for i=1:2
% o=x(i); %column
% n=y(i); %row
%  new(n,o)=255;
% end

hold on;
plot(x,y, 'r*', 'Linewidth',1,'MarkerSize',1);
hold on;
end
