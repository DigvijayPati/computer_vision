L = load('ZED_video_left.mat');
R = load('ZED_video_right.mat');
tsl = L.im_ts;
tsr = R.im_ts;

a = 7;
b = 11;

dt_tsl = datetime(tsl,'TimeZone','Europe/Berlin','ConvertFrom','posixtime');
milisec1_l = num2str(tsl(a,3));
s1_l=strcat(datestr(dt_tsl(a,2)), {'.'},milisec1_l(1:3));

milisec2_l = num2str(tsl(b,3));
s2_l=strcat(datestr(dt_tsl(b,2)), {'.'},milisec2_l(1:3));

dt_tsr = datetime(tsr,'TimeZone','Europe/Berlin','ConvertFrom','posixtime');
milisecl_r = num2str(tsl(a,3));
s1_r=strcat(datestr(dt_tsr(a,2)), {'.'},milisecl_r(1:3));

milisec2_r = num2str(tsr(b,3));
s2_r=strcat(datestr(dt_tsr(b,2)), {'.'},milisec2_r(1:3));


if(strcmp(s1_l,s1_r)) && (strcmp(s2_l,s2_r))
    disp('The time stamp matchs in this frame!')
    text_label=strcat(s1_l,' ----> ',s2_l);

    im_left_1 = im2double(L.im(:,:,:,a));
    im_left_2 = im2double(L.im(:,:,:,b));

    im_right_1 = im2double(R.im(:,:,:,a));
    im_right_2 = im2double(R.im(:,:,:,b));

    f1_l = isurf(im_left_1);
    f2_l = isurf(im_left_2);
    k_l = f1_l.match(f2_l);
    m_l = k_l.subset(200);

    f1_r = isurf(im_right_1);
    f2_r = isurf(im_right_2);
    k_r = f1_r.match(f2_r);
    m_r = k_r.subset(200);

    mark1_l = zeros(length(m_l),2);
    mark2_l = zeros(length(m_l),2);

    mark1_r = zeros(length(m_r),2);
    mark2_r = zeros(length(m_r),2);

    for i = 1:length(m_l)
        [mark1_l(i,1)] = m_l(1,i).xy_(1,1);
        [mark1_l(i,2)] = m_l(1,i).xy_(2,1);
        [mark2_l(i,1)] = m_l(1,i).xy_(3,1);
        [mark2_l(i,2)] = m_l(1,i).xy_(4,1);    
    end

    for i = 1:length(m_r)
        [mark1_r(i,1)] = m_r(1,i).xy_(1,1);
        [mark1_r(i,2)] = m_r(1,i).xy_(2,1);
        [mark2_r(i,1)] = m_r(1,i).xy_(3,1);
        [mark2_r(i,2)] = m_r(1,i).xy_(4,1);    
    end



    figure('visible','off'); 

    showMatchedFeatures(im_left_1,im_left_2,mark1_l,mark2_l,'blend');
    im_l = getframe;
    im_l = im2double(im_l.cdata);
    im_l = insertText(im_l, [0 0], text_label, 'AnchorPoint','LeftTop','BoxColor', 'white', 'fontsize', 40);


    figure('visible','off');

    showMatchedFeatures(im_right_1,im_right_2,mark1_r,mark2_r,'blend');
    im_r = getframe;
    im_r = im2double(im_r.cdata);

    figure(3);
    imshowpair(im_l,im_r, 'montage');
    hold on;
else
    disp('The time stamp does not match in this frame!')
end