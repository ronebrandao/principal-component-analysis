close all

im = imread ('C:\Users\Ezequiel Rodrigues\Downloads\dice-d4-d6-d8-d10-d12-d20-images\dice\train\d4\d4_angle_color350.jpg');

% img = rgb2gray (im);

rng(3);
[L,Centers] = k_means(imgaussfilt3 (im, 1));

img = rgb2gray (L{2});

img = grayconnected (img, 1, 1, 10);

img = imfill (~img, 'holes');

figure; imshow(rgb2gray (bsxfun(@times, im, cast(img, 'like', im)) * 1.8));