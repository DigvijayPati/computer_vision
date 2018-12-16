L = load('ZED_video_left.mat');

R = load('ZED_video_right.mat');



% x = iread('sm.png','grey','double');

im_left_1 = im2double(L.im(:,:,:,1));

im_left_2 = im2double(L.im(:,:,:,20));



f1 = icorner(rgb2gray(im_left_1), 'nfeat', 100);

f2 = icorner(rgb2gray(im_left_2), 'nfeat', 100);

m = f1.match(f2);



idisp({im_left_1 im_left_2})

m.plot('w')
