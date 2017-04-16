lim = 100;
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
    axis([0 1 0 5]);
    fclose(fileId);
end
