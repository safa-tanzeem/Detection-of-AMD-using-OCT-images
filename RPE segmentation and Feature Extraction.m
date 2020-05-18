clc;
clear all;
close all;
cd('C:\Users\LENOVO\Desktop\New folder')
directory=dir;
dev=zeros(40,512);
% z=zeros(25,3);
for kk=3:length(directory)
directory(kk).name;
%Input image
image =imread(directory(kk).name);
G=adapthisteq(image);
select=uint8(imgaussfilt(G,0.1));
maxm = max(gray,[],2);
m = size(select);
sel =medfilt2(select);
% imshow(sel)

%RPE Segmentation
w=zeros(1,512);
for i=1:512
p=sel(:,i);
r=max(p); 
index=find(p==r);
w(i)=max(index);
y=w(i);
end
u=medfilt1(w,11);
k=1:512;
mn=ceil(mean(u));
l=repelem(mn,512);

for i=2:512
pp=abs(u(i)-mn);
if pp>50
    u(i)=u(i-1);
else
    u(i)=u(i);
end
end
% u(abs(u-mn)>25)=NaN;

dev(kk-2,:)=ceil(u-mn); %deviation feature
s=sum(abs(dev'));
sk=abs(skewness(u));
kurt=kurtosis(u);
 figure;
% lm=fit(k,u,'poly2');
SEL=imread('C:\Users\LENOVO\Desktop\f_control\train\15.jpg');
% S=adapthisteq(SEL);
imshow(SEL)
hold on;
plot(k,u,'r*','Linewidth',1,'MarkerSize',1);
% hold on;
% plot(k,l,'g*', 'Linewidth',1,'MarkerSize',1);

          
%Feature Extraction
count_1=0;
count_neg1=0;
count=0;
for i=2:512
    d(i)=u(i)-u(i-1);
end

for i=1:512
    if d(i)>0
        count_1=count_1+1;
    elseif d(i)==0
        count=count+1;
    elseif d(i)<0
            count_neg1=count_neg1+1;
        end
end
% diff(find([1,diff(u),1]))
%z(kk-2,:)=[count count_1 count_neg1];
T(kk-2,:)=table(count, count_1, count_neg1, sk,kurt);
end
save('C:\Users\LENOVO\Desktop\features\2\fatures_train_c.mat','T');
