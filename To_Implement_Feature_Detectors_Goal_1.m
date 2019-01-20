clear
warning('off','all')
L = load('C:\Users\Kiran\Documents\FH_Dortmund\Semester3\Projects\Projects\New_Images\ZED_video_left.mat');
R = load('C:\Users\Kiran\Documents\FH_Dortmund\Semester3\Projects\Projects\New_Images\ZED_video_right.mat');

a = 1; % Enter the frame number here

L_img_orig = rgb2gray(im2double(L.im(:,:,:,a)));
L_img_dist = imresize(imrotate(L_img_orig,-20),1.2);

Name = {};
Extract_Original = [];
Extract_Distorted = [];
Matched = [];
Utility = [];
E_Time = [];

for i = 1:20

    choice = menu('Choose the feature matching method :','BRISK','FAST','HARRIS','MIN EIGEN','MSER','SURF','ISURF','ICORNER');


    if (choice == 0)
        break
    elseif (choice == 1)
        tic;
        points1 = detectBRISKFeatures(L_img_orig);
        points2 = detectBRISKFeatures(L_img_dist);
        [features1,valid_points1] = extractFeatures(L_img_orig,points1,'Method','BRISK');
        [features2,valid_points2] = extractFeatures(L_img_dist,points2,'Method','BRISK');
        indexPairs = matchFeatures(features1,features2);    
        best_match_stereo_frame_Lt_1 = valid_points1(indexPairs(:,1),:);
        best_match_stereo_frame_Rt_1 = valid_points2(indexPairs(:,2),:);
        Name = [Name; 'BRISK']
        Matched(i,1) = length(indexPairs)
        Extract_Original(i,1) = length(features1.Features)
        Extract_Distorted(i,1) = length(features2.Features)
        Utility(i,1) = (Matched(i,1)/Extract_Original(i,1)) * 100
        E_Time(i,1) = toc
    elseif (choice == 2)
        tic;
        points1 = detectFASTFeatures(L_img_orig);
        points2 = detectFASTFeatures(L_img_dist);
        [features1,valid_points1] = extractFeatures(L_img_orig,points1);
        [features2,valid_points2] = extractFeatures(L_img_dist,points2);
        indexPairs = matchFeatures(features1,features2);    
        best_match_stereo_frame_Lt_1 = valid_points1(indexPairs(:,1),:);
        best_match_stereo_frame_Rt_1 = valid_points2(indexPairs(:,2),:);
        Name = [Name; 'FAST']
        Matched(i,1) = length(indexPairs)
        Extract_Original(i,1) = length(features1.Features)
        Extract_Distorted(i,1) = length(features2.Features)
        Utility(i,1) = (Matched(i,1)/Extract_Original(i,1)) * 100
        E_Time(i,1) = toc
    elseif (choice == 3)
        tic;
        points1 = detectHarrisFeatures(L_img_orig);
        points2 = detectHarrisFeatures(L_img_dist);
        [features1,valid_points1] = extractFeatures(L_img_orig,points1);
        [features2,valid_points2] = extractFeatures(L_img_dist,points2);
        indexPairs = matchFeatures(features1,features2);    
        best_match_stereo_frame_Lt_1 = valid_points1(indexPairs(:,1),:);
        best_match_stereo_frame_Rt_1 = valid_points2(indexPairs(:,2),:);
        Name = [Name; 'HARRIS']
        Matched(i,1) = length(indexPairs)
        Extract_Original(i,1) = length(features1.Features)
        Extract_Distorted(i,1) = length(features2.Features)
        Utility(i,1) = (Matched(i,1)/Extract_Original(i,1)) * 100
        E_Time(i,1) = toc
    elseif (choice == 4)
        tic;
        points1 = detectMinEigenFeatures(L_img_orig);
        points2 = detectMinEigenFeatures(L_img_dist);
        [features1,valid_points1] = extractFeatures(L_img_orig,points1);
        [features2,valid_points2] = extractFeatures(L_img_dist,points2);
        indexPairs = matchFeatures(features1,features2);    
        best_match_stereo_frame_Lt_1 = valid_points1(indexPairs(:,1),:);
        best_match_stereo_frame_Rt_1 = valid_points2(indexPairs(:,2),:);
        Name = [Name; 'MIN_EIGEN']
        Matched(i,1) = length(indexPairs)
        Extract_Original(i,1) = length(features1.Features)
        Extract_Distorted(i,1) = length(features2.Features)
        Utility(i,1) = (Matched(i,1)/Extract_Original(i,1)) * 100
        E_Time(i,1) = toc
    elseif (choice == 5)
        tic;
        points1 = detectMSERFeatures(L_img_orig);
        points2 = detectMSERFeatures(L_img_dist);
        [features1,valid_points1] = extractFeatures(L_img_orig,points1);
        [features2,valid_points2] = extractFeatures(L_img_dist,points2);
        indexPairs = matchFeatures(features1,features2);    
        best_match_stereo_frame_Lt_1 = valid_points1(indexPairs(:,1),:);
        best_match_stereo_frame_Rt_1 = valid_points2(indexPairs(:,2),:);
        Name = [Name; 'MSER']
        Matched(i,1) = length(indexPairs)
        Extract_Original(i,1) = length(features1)
        Extract_Distorted(i,1) = length(features2)
        Utility(i,1) = (Matched(i,1)/Extract_Original(i,1)) * 100
        E_Time(i,1) = toc
    elseif (choice == 6)
        tic;
        points1 = detectSURFFeatures(L_img_orig);
        points2 = detectSURFFeatures(L_img_dist);
        [features1,valid_points1] = extractFeatures(L_img_orig,points1,'Method','SURF');
        [features2,valid_points2] = extractFeatures(L_img_dist,points2,'Method','SURF');
        indexPairs = matchFeatures(features1,features2);    
        best_match_stereo_frame_Lt_1 = valid_points1(indexPairs(:,1),:);
        best_match_stereo_frame_Rt_1 = valid_points2(indexPairs(:,2),:);
        Name = [Name; 'SURF']
        Matched(i,1) = length(indexPairs)
        Extract_Original(i,1) = length(features1)
        Extract_Distorted(i,1) = length(features2)
        Utility(i,1) = (Matched(i,1)/Extract_Original(i,1)) * 100
        E_Time(i,1) = toc
    elseif (choice == 7)
        tic;
        points1 = isurf(L_img_orig);
        points2 = isurf(L_img_dist);
        isurf_match_points = points1.match(points2);
        F = isurf_match_points.ransac(@fmatrix,1e-4,'verbose');
        best_match_stereo_frame_Lt_1 = isurf_match_points.inlier.p1;
        best_match_stereo_frame_Rt_1 = isurf_match_points.inlier.p2;
        best_match_stereo_frame_Lt_1 = best_match_stereo_frame_Lt_1';
        best_match_stereo_frame_Rt_1 = best_match_stereo_frame_Rt_1';        
        Name = [Name; 'ISURF']
        Matched(i,1) = length(isurf_match_points.inlier)
        Extract_Original(i,1) = length(points1)
        Extract_Distorted(i,1) = length(points2)
        Utility(i,1) = (Matched(i,1)/Extract_Original(i,1)) * 100
        E_Time(i,1) = toc
    elseif (choice == 8)    
        tic;
        points1 = icorner(L_img_orig);%, 'nfeat', 200, 'suppress', 10);
        points2 = icorner(L_img_dist);
        icorner_match_points = points1.match(points2);
        F = icorner_match_points.ransac(@fmatrix,1e-4,'verbose');
        best_match_stereo_frame_Lt_1 = icorner_match_points.inlier.p1;
        best_match_stereo_frame_Rt_1 = icorner_match_points.inlier.p2;
        best_match_stereo_frame_Lt_1 = best_match_stereo_frame_Lt_1';
        best_match_stereo_frame_Rt_1 = best_match_stereo_frame_Rt_1';
        Name = [Name; 'ICORNER']
        Matched(i,1) = length(icorner_match_points.inlier)
        Extract_Original(i,1) = length(points1)
        Extract_Distorted(i,1) = length(points2)
        Utility(i,1) = (Matched(i,1)/Extract_Original(i,1)) * 100
        E_Time(i,1) = toc
    else
        break
    end

    clear points1 points2 features1 valid_points1 features2 valid_points2 indexPairs

    close all
    figure(1); ax = axes;
    showMatchedFeatures(L_img_orig,L_img_dist,best_match_stereo_frame_Lt_1,best_match_stereo_frame_Rt_1,'blend');
    title(['Frame :',num2str(a)])
    clear best_match_stereo_frame_Lt_1 best_match_stereo_frame_Rt_1
    clear isurf_match_points icorner_match_points F fmatrix

end


T = table(Name,Extract_Original,Extract_Distorted,Matched,Utility,E_Time)
