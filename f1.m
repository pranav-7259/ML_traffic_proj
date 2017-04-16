high = 75;
moderate = 50;
low = 35;
verylow = 20;

for t = 101:104
    countbl = 0;
    countwl = 0;
    m=imread([num2str(t) '.jpg']);
    %imshow(m);
    m1 = rgb2gray(m);
    m2 = GraytoSegment(m1); 
    %imshow(m2);
    [r,c] = size(m2);
    for i = 1:r
        for j = 1:c
            if m2(i,j) == 0
                countbl = countbl+1;
            else
                countwl = countwl+1;
            end
        end
    end
    pbl = countbl/(r*c);
    pwl = countwl/(r*c);
    fileId = fopen('data.txt','a');
    fseek(fileId,0,'eof');
    fprintf(fileId,'%f \t %f \n',pbl,pwl/pbl);
    P = dlmread('data.txt','\t');
    fclose(fileId);
end

IDX = kmeans(P(:,1:2),4);

vht = IDX(33);
ht = IDX(1);
lt = IDX(7);
vlt = IDX(2);

time = 0;
str = 'hello';

for i = 101:104
    
    if IDX(i) == vht
        str = 'high';
        time = (high*((1-P(i,1))+1))/2;
    end
    if IDX(i) == vlt
        str = 'Very low';
        time = (verylow*((1-P(i,1))+1))/2;
    end
    if IDX(i) == ht
        str = 'moderate';
        time = (moderate*((1-P(i,1))+1))/2;
    end
    if IDX(i) == lt
        str = 'low';
        time = (low*(1-(P(i,1))+1))/2;
    end
    figure;imshow([num2str(i) '.jpg']); title(time);
    
end
%disp(50+i-1);
%figure;imshow([num2str(50+i) '.jpg']); title(time);
figure
axis([0 1 0 5]);
for k = 1:54
    text(P(k,1),P(k,2),num2str(IDX(k))) ;hold on;
end