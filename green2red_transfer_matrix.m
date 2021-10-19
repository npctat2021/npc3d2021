%% Calculate the transfer matrix for aligning one image with respect to another image captured in the same camera field, by using beads
%% p=1 when you know the position of bead in green channel (x) what will be its position in red channel (y) 
%% p=2 when you know the position of bead in red channel (x) what will be its position in green channel (y)
function green2red_transfer_matrix
clc
clear
pixel_size=118;
p=1;
fold_name='C:\G Drive Back Up\TAMHSC\Figure for ms\Programs to upload\Track\color mismatch matrix\';
file_name1='calib-green'; % for p=2, this should be 'calib-red'
file_name2='calib-red'; % for p=2, this should be 'calib-green'
%% calculate alignment matrix
green=load([fold_name file_name1 '.txt']);
xy_green=[green(:,1),green(:,2)];
red=load([fold_name file_name2 '.txt']);
xy_red=[red(:,1),red(:,2)];
base_points=xy_green; % base points is same as xy_green
input_points=xy_red; % input points is same as xy_red
map_func=inline('fit_arg(1)*xdata(:,1)+fit_arg(2)*xdata(:,2)+fit_arg(3)','fit_arg','xdata'); % defining a 1st order polynomial function
% find initial guesses for step 2
fit_arg_x=polyfit(base_points(:,1),input_points(:,1),1); % 1st order polynomial fit (y=a1*x+a2) of green channel x-pixels (x) & red channel x-pixels (y), output is [a1, a2] 
fit_arg_y=polyfit(base_points(:,2),input_points(:,2),1); % 1st order polynomial fit (y=b1*x+b2) of green channel y-pixels (x) & red channel y-pixels (y), output is [b1, b2]
xdata=base_points;
fit_arg=[fit_arg_x(1) 0 fit_arg_x(2)]; % fit_arg_x(1) is a1, fit_arg_x(2) is b1 
options=optimset('lsqcurvefit');
options=optimset(options,'display','off');
px=lsqcurvefit(map_func,fit_arg,xdata,input_points(:,1),[],[],options); % expressing red channel x-pixel in terms of green channel x-pixel and y-pixel, px=[px1,px2,px3]
fit_arg=[0 fit_arg_y(1) fit_arg_y(2)];
options=optimset('lsqcurvefit');
options=optimset(options,'display','off');
py=lsqcurvefit(map_func,fit_arg,xdata,input_points(:,2),[],[],options); % expressing red channel x-pixel in terms of green channel x-pixel and y-pixel, py=[py1,py2,py3]
plot(px(1)*base_points(:,1)+px(2)*base_points(:,2)+px(3),py(1)*base_points(:,1)+py(2)*base_points(:,2)+py(3),'r*',input_points(:,1),input_points(:,2),'bo')
saveas(gcf,[fold_name num2str(p) 'alignment.fig'])
pxy=[px',py']; % this is the alignment matrix 
%% calculate the error
x_error=(px(1)*base_points(:,1)+px(2)*base_points(:,2)+px(3)-input_points(:,1))
y_error=(py(1)*base_points(:,1)+py(2)*base_points(:,2)+py(3)-input_points(:,2))
x_error_m=mean(abs(x_error))
y_error_m=mean(abs(y_error))
if p==1
save([fold_name 'g2r_transfer_matrix' '.txt'],'-ascii','pxy');
else
save([fold_name 'r2g_transfer_matrix' '.txt'],'-ascii','pxy');
end
end