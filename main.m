% Use this file for centerline detection algorithm after applying out the
% fractional filter and do not forget to do PCA before applying centerline
% algorithm

%clc;
%clear all;
%image_folder='C:\Users\RAHUL\OneDrive\Desktop\Centerline\images'; % Place the path of your folder here
%filename = dir(fullfile(image_folder,'*.tif'));
%total_images=numel(filename);
%Final_image_folder= 'C:\Users\RAHUL\OneDrive\Desktop\Centerline\Final_images';
%for n = 1:total_images
%    f=fullfile(image_folder,filename(n).name);
%    A=imread(f);
%    [C_V,C_H,C_45,C_135]=util(A);
%    A_f=bitor(im2bw(C_V),im2bw(C_H));
%    A_d=bitor(im2bw(C_135),im2bw(C_45));
%    A_f=bitor(A_f,A_d);
%    imshow(A_d);
%end
A=imread('40_training.tif');
[C_V,C_H,C_45,C_135]=util(A);
BC_V=imbinarize(C_V);
BC_H=imbinarize(C_H);
BC_45=imbinarize(C_45);
BC_135=imbinarize(C_135);
BC_V = bwareaopen(BC_V, 20);
BC_H = bwareaopen(BC_H, 20);
%BC_45 = bwareaopen(BC_45, 5);
%BC_135 = bwareaopen(BC_135, 5);
A_f=bitor(BC_V,BC_H);
A_d=bitor(BC_45,BC_135);
A_f=bitor(A_f,A_d);
%imwrite(C_H,'H_centerline.jpg');
%imwrite(C_V,'V_centerline.jpg');
%imwrite(C_45,'45_centerline.jpg');
%imwrite(C_135,'135_centerline.jpg');
imwrite(A_f,'Final_image40.tif');
%imshow(A_f);
