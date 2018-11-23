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
% ���Ļ�������Э�������
img_pj = mean(imagedata,2);
for i = 1:wts
    imagedata(:,i) = imagedata(:,i) - img_pj;  
end
covMat = imagedata'*imagedata;
%˵����[PC,latent,explained]=pcacov(X)ͨ��Э�������X �������ɷַ������������ɷ�(PC)��
%Э�������X ������ֵ (latent)��ÿ���������������ڹ۲����ܷ�������ռ�İٷ���
%(explained)��
[COEFF, latent, explained] = pcacov(covMat);
% ѡ�񹹳�95%����������ֵ
i = 1;
proportion = 0;
while(proportion < 95)
    proportion = proportion + explained(i);
    i = i+1;
end
k = i - 1;
%���ԭЭ��������������������������
V = imagedata*COEFF; % N*M ��
V = V(:,1:k);
% ѵ��������PCA �����ռ��µı����� k*M
W = V'*imagedata;
msgbox('ѵ�����');
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


