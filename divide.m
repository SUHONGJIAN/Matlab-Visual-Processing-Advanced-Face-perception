clc;
clear;
n = 1;
p=1;
for i=1:40
    a=1:10;
    Ind = a(:,randperm(size(a,2)));
    for h = 1:5
        j= Ind(1,h);
        File=['...\s',sprintf('%d',i),'\',sprintf('%d',j),'.pgm'];
        Filesave=['...\SU',sprintf('%d',1),'\',sprintf('%03d',n),'.pgm'];
        copyfile(File,Filesave);
        n = n + 1;
    end
    for h = 6:10
        j= Ind(1,h);
        File=['...\s',sprintf('%d',i),'\',sprintf('%d',j),'.pgm'];
        Filesave=['...\SU',sprintf('%d',2),'\',sprintf('%03d',p),'.pgm'];
        copyfile(File,Filesave);
        p = p + 1;
     end
end

