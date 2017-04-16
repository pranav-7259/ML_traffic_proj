x = 0
a = segmentedImage(:)
len = length(a)
for i = 1:len
    if(a(i) == 0)
        x = x+1
    end
    
end
y=len-x
plot(x,y,'--rs','LineWidth',2,...
                       'MarkerEdgeColor','k',...
                       'MarkerFaceColor','g',...
                       'MarkerSize',10)