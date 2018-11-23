clc;
clear;
cd '...'
path = '...';
img_path = dir(strcat(path,'\*.pgm'));
img_num = length(img_path);
imagedata = [];
if img_num >0
    for j = 1:img_num
        img_name = img_path(j).name;
        temp = imread(strcat(path, '/', img_name));
        temp = double(temp(:));
        imagedata = [imagedata, temp];
    end
end
wts = size(imagedata,2);
% 中心化并计算协方差矩阵
img_pj = mean(imagedata,2);
for i = 1:wts
    imagedata(:,i) = imagedata(:,i) - img_pj;  
end
covMat = imagedata'*imagedata;
%说明：[PC,latent,explained]=pcacov(X)通过协方差矩阵X 进行主成分分析，返回主成分(PC)、
%协方差矩阵X 的特征值 (latent)和每个特征向量表征在观测量总方差中所占的百分数
%(explained)。
[COEFF, latent, explained] = pcacov(covMat);
% 选择构成95%能量的特征值
i = 1;
proportion = 0;
while(proportion < 95)
    proportion = proportion + explained(i);
    i = i+1;
end
k = i - 1;
%求出原协方差矩阵的特征向量，即特征脸
V = imagedata*COEFF; % N*M 阶
V = V(:,1:k);
% 训练样本在PCA 特征空间下的表达矩阵 k*M
W = V'*imagedata;
msgbox('训练完成');
for i = 2:2:40
    s = [...\SU2\',sprintf('%03d',i),'.pgm'];
    im=imread(s);
    im = double(im(:));
    objectone = V'*(im - img_pj);
    distance = 1e8;
    for k = 1:wts
        temp_2(k) = norm(objectone - W(:,k));
    end
    [s_temp,id]=sort(temp_2,'ascend');
    s1 = ['...\SU1\',sprintf('%03d',id(1)),'.pgm'];
    s2 = ['...\SU1\',sprintf('%03d',id(2)),'.pgm'];
    s3 = ['...\SU1\',sprintf('%03d',id(3)),'.pgm'];
    figure,
    subplot(2,3,2);imshow(s);
    subplot(2,3,4);imshow(s1);
    subplot(2,3,5);imshow(s2);
    subplot(2,3,6);imshow(s3);
end


