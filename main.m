clc;
clear all;
image_folder='C:\Users\RAHUL\OneDrive\Desktop\Centerline\images'; % Place the path of your folder here
filename = dir(fullfile(image_folder,'*.tif'));
total_images=numel(filename);
Final_image_folder= 'C:\Users\RAHUL\OneDrive\Desktop\Centerline\Final_images';
for n = 1:total_images
    f=fullfile(image_folder,filename(n).name);
    A=imread(f);
    [C_V,C_H,C_45,C_135]=util(A);
    A_f=bitor(im2bw(C_V),im2bw(C_H));
    A_d=bitor(im2bw(C_135),im2bw(C_45));
    A_f=bitor(A_f,A_d);
    imshow(A_d);
end    
