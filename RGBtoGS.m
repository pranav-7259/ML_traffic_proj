lim = 50;
for i = 1:lim
    countbl = 0;
    countwl = 0;
    m=imread([num2str(i) '.jpg']);
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
    plot(P(:,1),P(:,2),'.')
    axis([0 1 0 1]);
    fclose(fileId);
end

IDX = kmeans(P(:,1:2),4);

for k = 1:lim
    text(P(k,1),P(k,2),num2str(IDX(k))) ;hold on;
end

for t = 101:104    
    %prompt='Enter the test data file name ';
    %ip = input(prompt,'s');
    x=imread([num2str(i) '.jpg']);
    m1 = rgb2gray(x);
    m2 = GraytoSegment(m1);
    vht = IDX(33);
    ht = IDX(1);
    lt = IDX(7);
    vlt = IDX(2);
    [r,c] = size(m2);
    countbl = 0;
    countwl = 0;
    for i1 = 1:r
            for j = 1:c
                if m2(i1,j) == 0
                    countbl = countbl+1;
                else
                    countwl = countwl+1;
                end
            end
    end
    pbl = countbl/(r*c);
    pwl = countwl/(r*c);
    str = 'hello';
    fileId = fopen('data.txt','a');
    fseek(fileId,0,'eof');
    fprintf(fileId,'%f \t %f \n',pbl,pwl/pbl);
    
    if IDX(lim+i) == vht
        str = 'Very high';
    end
    if IDX(lim+i) == vlt
        str = 'Very low';
    end
    if IDX(lim+i) == ht
        str = 'high';
    end
    if IDX(lim+i) == lt
        str = 'low';
    end
    subplot(2,2,t); title(str);
    fclose(fileId);
end