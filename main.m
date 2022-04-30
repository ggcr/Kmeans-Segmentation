% Nom: Cristian Gutiérrez Gómez
% NIU: 1532397

% Clear MATLAB envoirnment
clc; close all; imtool close all; clear; format short;

method = 'rgb';

% PARAMETRES
k = 8;
limit_it = 999999;

for methods = 1:2
    tic

    im = im2uint8(imread("input_imgs/luna.png"));
    
    if(strcmp(method, "rgb"))
        im = im2double(im);
    else
        im = rgb2hsv(im);
    end
    
    filename = strcat("input_imgs/luna_input_", method, ".jpg");
    imwrite(im, filename);
    figure,imshow(im)

    arr = reshape(im, [], 3);

    % KMEANS
    [clusters, centres] = kmeans(im, arr, k, limit_it);


    clusters = reshape(clusters, [size(im,1),size(im,2)]);

    if(strcmp(method, "rgb"))
        centres = uint8(centres*255);
        final_im = im2uint8(zeros(size(im)));
    else
        im = rgb2hsv(im);
        final_im = zeros(size(im));
    end

    % CONSTRUCCIO IMG
    for i = 1:size(clusters,1)
        for j = 1:size(clusters,2)
            final_im(i,j,:) = centres(clusters(i,j),:);
        end
    end

    filename = strcat("output_imgs/luna_", num2str(k), "_", method, ".jpg");

    if(strcmp(method, "rgb"))
        method = "hsv";
    else
        final_im = hsv2rgb(final_im);
        method_ = "rgb";
    end

    imwrite(final_im, filename);
    figure,imshow(final_im)

    toc
end


