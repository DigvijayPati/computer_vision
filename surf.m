L = load('ZED_video_left.mat');

R = load('ZED_video_right.mat');



im_left_1 = im2double(L.im(:,:,:,1));

im_left_2 = im2double(L.im(:,:,:,20));



f1 = isurf(im_left_1);

f2 = isurf(im_left_2);

m = f1.match(f2);



idisp({im_left_1 im_left_2})

m.subset(100).plot('w')
