function [B]= Fractional_Filter_application(A)
filter=Fractional_Filter(2);
A=rgb2gray(A);
A=im2double(A);
B=A;
B=imfilter(B,filter);