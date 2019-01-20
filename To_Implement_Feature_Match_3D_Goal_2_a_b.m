clear
warning('off','all')
L = load('C:\Users\Kiran\Documents\FH_Dortmund\Semester3\Projects\Projects\New_Images\ZED_video_left.mat');
R = load('C:\Users\Kiran\Documents\FH_Dortmund\Semester3\Projects\Projects\New_Images\ZED_video_right.mat');
fx_l = 1398.41;
fy_l = 1398.41;
cx_l = 923.113;
cy_l = 550.247;
k1_l = -0.17121;
k2_l = 0.026171;
fx_r = 1401.62;
fy_r = 1401.62;
cx_r = 944.482;
cy_r = 548.772;
k1_r = -0.16997;
k2_r = 0.024937;
baseline = 120;

% cx_l = 640; % 923.113;
% cy_l = 360; % 550.247;

% cx_r = 640; % 944.482;
% cy_r = 360; % 548.772;

Im_L = [fx_l,    0,       0;
        0,       fy_l,    0;
        cx_l,    cy_l,    1];
    
RD_L = [k1_l k2_l];
cameraParams_Left = cameraParameters('IntrinsicMatrix',Im_L,'RadialDistortion',RD_L);

Im_R = [fx_r,    0,       0;
        0,       fy_r,    0;
        cx_r,    cy_r,    1];
    
RD_R = [k1_r k2_r]; 
cameraParams_Right = cameraParameters('IntrinsicMatrix',Im_R,'RadialDistortion',RD_R);

a = 1; % Insert the frame number here

L_img_1 = rgb2gray(im2double(L.im(:,:,:,a)));
R_img_1 = rgb2gray(im2double(R.im(:,:,:,a)));

% points1 = detectMinEigenFeatures(L_img_1);
% points2 = detectMinEigenFeatures(R_img_1);
% [features1,valid_points1] = extractFeatures(L_img_1,points1);
% [features2,valid_points2] = extractFeatures(R_img_1,points2);
% indexPairs = matchFeatures(features1,features2);    
% best_match_stereo_frame_Lt_1 = valid_points1(indexPairs(:,1),:);
% best_match_stereo_frame_Rt_1 = valid_points2(indexPairs(:,2),:);
% final_left_1 = best_match_stereo_frame_Lt_1.Location;
% final_right_1 = best_match_stereo_frame_Rt_1.Location;

stereo_feature_Lt_frame_1 = isurf(L_img_1);
stereo_feature_Rt_frame_1 = isurf(R_img_1);
stereo_match_frame_1 = stereo_feature_Lt_frame_1.match(stereo_feature_Rt_frame_1);
fundamental_stereo_match_frame_1 = stereo_match_frame_1.ransac(@fmatrix,1e-4,'verbose');

for i = 1:length(stereo_match_frame_1)
    if (stereo_match_frame_1(1,i).inlier_ == 1)
        [best_match_stereo_frame_Lt_1.Location(i,1)] = stereo_match_frame_1(1,i).xy_(1,1);
        [best_match_stereo_frame_Lt_1.Location(i,2)] = stereo_match_frame_1(1,i).xy_(2,1);
        [best_match_stereo_frame_Rt_1.Location(i,1)] = stereo_match_frame_1(1,i).xy_(3,1);
        [best_match_stereo_frame_Rt_1.Location(i,2)] = stereo_match_frame_1(1,i).xy_(4,1); 
    end
end

final_left_1 = best_match_stereo_frame_Lt_1.Location;
final_right_1 = best_match_stereo_frame_Rt_1.Location;
   
p = 1;
for p = 1:length(final_left_1)
    di_L_1(p,1) = final_right_1(p,1) - final_left_1(p,1);        
end

di_L_1 = di_L_1 + 100; %274;    

u0 = cx_l; 
v0 = cy_l;

p = 1;
for p = 1:length(final_left_1)
    X_1(p,1) = baseline*(final_left_1(p,1)-u0) ./ di_L_1(p,1); 
    Y_1(p,1) = baseline*(final_left_1(p,2)-v0) ./ di_L_1(p,1); 
    Z_1(p,1) = 1398.41 * baseline ./ di_L_1(p,1);
end

p = 1;
for p = 1:length(final_left_1)
worldPoints_1(p,1) = X_1(p,1);
worldPoints_1(p,2) = Y_1(p,1);
worldPoints_1(p,3) = 16000 - Z_1(p,1);
end

for p = 1:length(final_left_1)
labels_1 = cellstr(num2str(worldPoints_1));

end

close all

figure(1); ax = axes;
showMatchedFeatures(L_img_1,R_img_1,final_left_1,final_right_1,'montage');
title(['Frame :',num2str(a)])
hold off;




figure(2); ax = axes;
showMatchedFeatures(L_img_1,R_img_1,final_left_1,final_right_1,'blend');
hold on;
text(double(final_left_1(:,1)),double(final_left_1(:,2)),labels_1,'color','red','VerticalAlignment','bottom','HorizontalAlignment','right');
title(['Frame :',num2str(a)])
plot(cx_l, cy_l,'g*');
hold off;

fundamental_horizontal_match_frame_1 = estimateFundamentalMatrix(final_left_1,final_right_1);


[orientation, location] = cameraPose(fundamental_horizontal_match_frame_1, cameraParams_Left, cameraParams_Right, final_left_1, final_right_1);
rotationMatrix = orientation';
translationVector = -location * rotationMatrix;

figure(3);
pcshow(worldPoints_1,'VerticalAxis','Y','VerticalAxisDir','down','MarkerSize',70);
hold on;
plotCamera('Size',200,'Orientation',orientation,'Location',location);
hold off;

clear best_match_stereo_frame_Lt_1 best_match_stereo_frame_Rt_1 di_L_1 features1 features2
clear final_left_1 final_right_1 fundamental_horizontal_match_frame_1 indexPairs L_img_1 R_img_1 labels_1
clear location orientation points1 points2 rotationMatrix translationVector valid_points1 valid_points2 worldPoints_1
clear X_1 Y_1 Z_1
