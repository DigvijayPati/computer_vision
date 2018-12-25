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


L = load('ZED_video_left.mat');
R = load('ZED_video_right.mat');

tsl = L.im_ts;
tsr = R.im_ts;

dt_tsl = datetime(tsl,'TimeZone','Europe/Berlin','ConvertFrom','posixtime');

i = 2; %Enter the frame number here

im_left_1 = im2double(L.im(:,:,:,i));
im_right_1 = im2double(R.im(:,:,:,i));

Left_f = isurf(im_left_1);
Right_f = isurf(im_right_1);
m_all = Left_f.match(Right_f);
m = m_all.subset(20);

mark_l = zeros(length(m),2);
mark_r = zeros(length(m),2);

for i = 1:length(m)
    [mark_l(i,1)] = m(1,i).xy_(1,1);
    [mark_l(i,2)] = m(1,i).xy_(2,1);
    [mark_r(i,1)] = m(1,i).xy_(3,1);
    [mark_r(i,2)] = m(1,i).xy_(4,1);
end


d = istereo(im_left_1,im_right_1,[5 87],3);

desparity = zeros(length(mark_l),3);
for i = 1:length(mark_l)
    desparity(i,3) = ((fx_l*baseline)/(-d(uint32(mark_l(i,2)),uint32(mark_l(i,1)))));
    desparity(i,2)= ((m(1,i).xy_(2,1))-cx_l)*desparity(i,3)/fx_l;
    desparity(i,1)= ((m(1,i).xy_(1,1))-cy_l)*desparity(i,3)/fy_l;    
end
% figure(1);
labels = cellstr(num2str(desparity));

idisp(im_left_1);
axis on;
hold on;
plot(mark_l(:,1),mark_l(:,2),'yd');
text(mark_l(:,1),mark_l(:,2),labels,'color','red','VerticalAlignment','bottom','HorizontalAlignment','right');
plot(cx_l,cy_l,'b*');
%figure(2);
%showMatchedFeatures(im_left_1,im_right_1,mark_l,mark_r,'blend');

%figure(3);
%idisp(d);

