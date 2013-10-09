function [] = HW1()


%% Convert Image filename to array
    function img = loadfig(x)
        
        img = rgb2gray(imread(x));
    
    end
%% Load image. If its a array then display, if not loadfig and then display
    function y = loadview(x)
        
        if ischar(x)
        
            img = loadfig(x);
            
        else
            img = x;
        
        end

        
        imshow(x);
          
    end
%% Subsample image by 2

    function y = subsample2(x)
    
        shape = size(x)
        new_shape = shape/2
        y = zeros(new_shape);
    
        for ii = 1:new_shape(1)
            for jj = 1:new_shape(2)
                y(ii,jj) = x(ii*2-1,jj*2-1);
            end
        end
    
    end


%% Crop

    function y = crop(x)
    
        shape = size(x);
        y = zeros(shape/2+60)
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
        y = [];
    
    end



%% Main part of the function here

figure(1)
subplot(231)
img = loadfig('puppy.jpg');
%loadview(img)
title('Original Image')

subplot(232)
img_sub = subsample2(img);
%loadview(img_sub);
title('Subsampled by 2');
size(img)
subplot(233)
img_crop = crop(img);
loadview(img_crop);
title('Cropped');
size(img)
size(img_crop)
subplot(234)
img_fv = fvert(img);
%loadview(img_sub);
imshow(img_fv)
title('Flipped Vertically');

subplot(235)
img_fh = fhoriz(img);
%loadview(img_sub);
imshow(img_fh)
title('Flipped Horizontally');


subplot(236)
%img = loadfig('puppy.jpg');
loadview(img)
title('Original Image')

end