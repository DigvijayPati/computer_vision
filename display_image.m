L = load('ZED_video_left.mat');

R = load('ZED_video_right.mat');



tsl = L.im_ts;

tsr = R.im_ts;



dt_tsl = datetime(tsl,'TimeZone','Europe/Berlin','ConvertFrom','posixtime');



i = 1; %Enter the frame number here



%sl=datestr(dt_tsl(i,2))      %'19-Nov-2018 15:15:47'



milisecl = num2str(tsl(i,3));

sl=strcat(datestr(dt_tsl(i,2)), {'.'},milisecl(1:3));



Framel = insertText(L.im(:,:,:,i), [0 0], sl, 'AnchorPoint','LeftTop','BoxColor', 'white', 'fontsize', 40);

%figure(1)

%imshow(Framel)





dt_tsr = datetime(tsr,'TimeZone','Europe/Berlin','ConvertFrom','posixtime');



milisecr = num2str(tsr(i,3));

sr=strcat(datestr(dt_tsr(i,2)), {'.'},milisecr(1:3));



Framer = insertText(R.im(:,:,:,i), [0 0], sr, 'AnchorPoint','LeftTop','BoxColor', 'white', 'fontsize', 40);

%figure(2)

%imshow(Framer)



imshowpair(Framel,Framer, 'montage');

title(['Frame : ',num2str(i)]);
