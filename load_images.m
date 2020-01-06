function [] = load_images()
    dirname = 'D:\Dropbox\project1\construction_crane\Andrew_Construction';
    files = dir(dirname);

    fileIndex = find(~[files.isdir]);

    for i = 1:length(fileIndex)
        fileName = files(fileIndex(i)).name;
        
        fullfile = strcat(dirname, '\', fileName);

        img = imread(fullfile);
        dims = size(img);
        
        pixels = dims(1)*dims(2);

        red = img(:,:,1); % Red channel
        green = img(:,:,2); % Green channel
        blue = img(:,:,3); % Blue channel

        red_thresh = im2bw(red, 0.5);
        green_thresh = im2bw(green, 0.5);
        blue_thresh = im2bw(blue, 0.5);
        
        red_feature = sum(sum(red_thresh))/pixels
        green_feature = sum(sum(green_thresh))/pixels
        blue_feature = sum(sum(blue_thresh))/pixels
        
        gray_img = rgb2gray(img);
        edge_img = edge(gray_img,'sobel');
        
        
        [H,theta,rho] = hough(edge_img);
        
        P = houghpeaks(H,5,'threshold',ceil(0.2*max(H(:))));
        lines = houghlines(edge_img,theta,rho,P,'FillGap',ceil(sqrt(pixels)/100),'MinLength',ceil(sqrt(pixels)/50));

        figure, imshow(img), hold on
        max_len = 0;
        for k = 1:length(lines)
           xy = [lines(k).point1; lines(k).point2];
           plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

           % Plot beginnings and ends of lines
           plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
           plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');

           % Determine the endpoints of the longest line segment
           len = norm(lines(k).point1 - lines(k).point2);
           if ( len > max_len)
              max_len = len;
              xy_long = xy;
           end
        end
        longest_edge_feature = sqrt(max_len)
        
        % highlight the longest line segment
        plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','red');
        pause
end

