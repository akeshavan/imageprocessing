function [] = HW1()
    clear
    close all
    clc

%% Convert Image filename to array
    function img = loadfig(x)
        
        img = rgb2gray(imread(x));
    
    end
%% Load image. If its a array then display, if not loadfig and then display
    function y = loadview(x)
        
        if ischar(x)
        
            y = loadfig(x);
            
        else
            y = x;
        
        end

        
        imshow(y);
          
    end
%% Subsample image by 2

    function y = subsample2(x)
    
         y = x(1:2:end,1:2:end);
   
    end


%% Crop

    function y = crop(x)
    
        shape = size(x);
        xmin = shape(1)/2 -30;
        xmax = shape(1)/2 +30;
        ymin = shape(2)/2 -30;
        ymax = shape(2)/2 +30;
        
        y = x(xmin:xmax,ymin:ymax);
        
    end

%% Flip Vertically
    function y = fvert(x)
    
        y = x(end:-1:1,1:end);
    
    end


%% Flip Horizontally

    function y = fhoriz(x)
        y = x(1:end,end:-1:1);
    
    end


%% Invert

    function y = invert(x)
        maxv = max(x(:));
        minv = min(x(:));
        y = maxv-x + minv;
    
    end



%% Main part of the function here



figure(1)
subplot(231)
img = loadfig('puppy.jpg');
loadview(img);
title('Original Image');

subplot(232)
img_sub = subsample2(img);
loadview(img_sub);
title('Subsampled by 2');

subplot(233)
img_crop = crop(img);
loadview(img_crop);
title('Cropped');

subplot(234)
img_fv = fvert(img);
loadview(img_fv);
title('Flipped Vertically');

subplot(235)
img_fh = fhoriz(img);
loadview(img_fh);
title('Flipped Horizontally');

subplot(236)
loadview(invert(img));
title('Inverted Image')

print(gcf, '-dbmp', 'part1_output.bmp')

%% TODO The program should also save each processed image 
% in .bmp format 

%% Pause
pause()

%% Data Types

f = [[-50.7 0.5 260.5];...
     [35.1 72.9 0.75]]

g = uint8(f)
display('Uint8 data ranges from 0 to 255 integers only and the numbers are all positive.')
display('That is why the the values 0.5 and 0.75 get mapped to 1')
display('35.1, 72.9 are rounded as well')
display('-50.7 gets mapped to 0 and 260 goes to 255')

g_im = im2uint8(f)

display('im2uint8 also converts the datatypes from 0 to 255 as integers,') 
display('but the values are scaled for the image to look approximately the same')

g_dbl = double(g)

display('information is lost once data conversion to uint8 happens,') 
display('so we cannot recover f by converting g to a double')

g_dbl_im = im2double(g)

display('Here we still lose the information we had in f') 
display('and again scaling and offsetting is done')


f_gray = mat2gray(f,[1,255])

g_gray = mat2gray(g,[1,255])

display('mat2gray scales values from 0 to 1 intensity.')
display('Note that g_gray is slightly different from f, because of gs datatype conversion error')


%% Pause
pause()

%% Quantization

    function y = quantize(x, b) 
        %Y = QUANTIZE(X,B) quantizes X to B bits. The quantized bits are in the 
        %upper half of the byte (ie 128, 64, etc) to aid in the display of the 
        %quantized image. 

        %Create bit masks for the quantization 
        lo = uint8(2 ^ (8 - b) - 1); 
        hi = uint8(2 ^ 8 - double(lo) - 1); 

        %Perform standard quantization 
        y = bitand(x,hi); 
    end 


    figure('Position', [100, 100, 1049, 200])
    for i=1:5
        qimg = quantize(img,i);
        subplot(150+i);
        loadview(qimg);
        title(['b = ' int2str(i)]);
        xlabel([int2str(length(unique(qimg))) ' colors']);
    end
    print(gcf, '-dbmp', 'quantize_output.bmp')
    
    
display('bitand converts the first and second inputs to binary,')
display('For each digit of each binary number, if the number match then it adds 2^k where k is the digit #')
display('it returns the final sum after comparing each digit in the binary number')
display('For example, 2 in binary is 10 and 3 is 11, so bitwise and should return 12^2 + 02^1 = 2')
display('since they match at the first digit (1 and 1) and dont match at the last digit (0 and 1)')
display('as we increase the number of bits, the image looks closer to the original')


end