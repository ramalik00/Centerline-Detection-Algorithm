function [C O]=vertical(A)
%A=imread('retinal1.jpg');
A=rgb2gray(A);
A=im2double(A);
B=A;
A=imcomplement(A);
[r c]=size(A);
%Vertical
vf=[-1 -2 0 2 1; -2 -4 0 4 2; -1 -2 0 2 1];
O=zeros(r,c);
C=zeros(r,c);
for i=2:r-1
    for j=3:c-2
        subimg=A(i-1:i+1,j-2:j+2);
        O(i,j)=sum(sum(vf.*subimg));
       % O2(i,j)=sum(sum(vf2.*subimg));
    end
end
for i=2:r-1

    for j=3:c-4
        flag=0;
        if O(i,j+1)>0 & O(i,j+2)<0
            
            adv=sum(O(i,j:j+3));
            
            if O(i,j)>0 & (O(i,j+3)<0 | adv>0)
                flag=1;
            else 
            end
            if adv<0 & O(i,j+3)<0
                flag=1;
            else
            end
        else
        end
        
        if flag==1
            [v,p]=max(A(i,j:j+3));
            C(i,j+p-1)=1;
        end
    end
end