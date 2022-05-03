function [C2 O2]=vertical(A)
%A=imread('retinal1.jpg');
A=rgb2gray(A);
A=im2double(A);
B=A;
A=imcomplement(A);
[r c]=size(A);
vf2=[-1 -2 -1; -2 -4 -2; 0 0 0 ; 2 4 2 ;1 2 1];
O2=zeros(r,c);
C2=zeros(r,c);
for i=3:r-2
    for j=2:c-1
        subimg=A(i-2:i+2,j-1:j+1);
        O2(i,j)=sum(sum(vf2.*subimg));
       % O2(i,j)=sum(sum(vf2.*subimg));
    end
end


for i=3:r-4

    for j=2:c-1
        flag=0;
        if O2(i+1,j)>0 & O2(i+2,j)<0
            
            adv=sum(O2(i:i+3,j));
            
            if O2(i,j)>0 & (O2(i+3,j)<0 | adv>0)
                flag=1;
            else 
            end
            if adv<0 & O2(i+3,j)<0
                flag=1;
            else
            end
        else
        end
        
        if flag==1
            [v,p]=max(A(i:i+3,j));
            C2(i+p-1,j)=1;
        end
    end
end
        