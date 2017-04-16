function segmentedImage = GraytoSegment(image1)
    I = image1;
    [~, threshold] = edge(I, 'sobel');
    fudgeFactor = .5;
    BWs = edge(I,'prewitt', threshold * fudgeFactor);
    se90 = strel('line', 3, 90);
    se0 = strel('line', 3, 0);
    BWsdil = imdilate(BWs, [se90 se0]);
    BWdfill = imfill(BWsdil, 'holes');
    
    segmentedImage = BWdfill;
end

