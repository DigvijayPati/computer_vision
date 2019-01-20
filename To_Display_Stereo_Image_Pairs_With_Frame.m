clear
warning('off','all')
L = load('C:\Users\Kiran\Documents\FH_Dortmund\Semester3\Projects\Projects\New_Images\ZED_video_left.mat');
R = load('C:\Users\Kiran\Documents\FH_Dortmund\Semester3\Projects\Projects\New_Images\ZED_video_right.mat');

tsl = L.im_ts;
tsr = R.im_ts;

dt_tsl = datetime(tsl,'TimeZone','Europe/Berlin','ConvertFrom','posixtime');
dt_tsr = datetime(tsr,'TimeZone','Europe/Berlin','ConvertFrom','posixtime');

for i = 1:5

    milisecl = num2str(tsl(i,3));
    sl=strcat(datestr(dt_tsl(i,2)), {'.'},milisecl(1:3));
    milisecr = num2str(tsr(i,3));
    sr=strcat(datestr(dt_tsr(i,2)), {'.'},milisecr(1:3));

    if(strcmp(sl,sr))
        disp(['The time stamp matches in frame number : ', num2str(i)])
        Framel = insertText(L.im(:,:,:,i), [0 0], sl, 'AnchorPoint','LeftTop','BoxColor', 'white', 'fontsize', 40);
        Framer = insertText(R.im(:,:,:,i), [0 0], sr, 'AnchorPoint','LeftTop','BoxColor', 'white', 'fontsize', 40);
        figure(1);
        imshowpair(Framel,Framer, 'montage');
        title(['Frame : ',num2str(i)]);
        pause(1);
    else
        disp(['The time stamp does not match in frame number : ',num2str(i)])
    end
    clear milisecl milisecr sl sr Framel Framer
end