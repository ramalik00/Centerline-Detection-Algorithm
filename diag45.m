function [C bwC]=diag45(A)

% aim: apply the diagonal DoOG filter, then search for the specific  
%      combinations of signs in DoOG filtered image, then search for 
%      the local maxima where ever the desired combination of signs is
%      detected, mark the position of local maxima in a new image.
% author: varun makkar
% reference: mendonca_ieee
% date: 23-02-2022

filter=[0 0 -1 0 0 0 0;0 -2 0 -2 0 0 0;-1 0 -4 0 0 0 0;....
     0 -2 0 0 0 2 0;0 0 0 0 4 0 1;0 0 0 2 0 2 0;0 0 0 0 1 0 0];
[m n]=size(filter);
A=rgb2gray(A);
A=im2double(A);
B=A;
A=imcomplement(A);
[r c]=size(A);
tm=floor(m/2);tn=floor(n/2);
B=zeros(r+2*tm,c+2*tn); 
B(tm+1:tm+r,tn+1:tn+c)=A; % zero padded A
DA=zeros(r,c);
C=zeros(r,c);
bwC=zeros(r,c);

% APPLY THE FILTER ON B
for i=tm+1:r+tm
    for j=tn+1:c+tn
        subimg=B(i-tm:i+tm,j-tn:j+tn);
        DA(i-tm,j-tn)=sum(sum(filter.*subimg));
    end
end


% SEARCH FOR SPECIFIC COMBINATION OF SIGNS IN DA
% 4-window search

for i=1:r
    for j=1:c 
        lenb=4;
        for step=0:3
            if i+step <=r & j+step <=c
                b(step+1)=DA(i+step,j+step);
            else 
                lenb=step;
                break;
            end
        end
        
        % if lenb=4 then b is of length 4 otherwise
        % length of b is less than 4 and in that case we don't
        % search for specific combination of signs.
        
        if lenb==4;
            flag=0;
            % look if b has the specific combination of signs
            adv=mean(b);
            if b(2)>0 & b(3)<0
                if b(1)>0 & ( b(4)<0 | adv>0 )
                    flag=1;
                end
                if adv<0 & b(4)<0
                    flag=1;
                end
            end
            % perform the search for the local maxima in the
            % underlying image if the specific combination of signs if 
            % detected i.e, if flag equals one
            if flag==1
                for step=0:3
                    a(step+1)=A(i+step,j+step);
                end
                [value position]=max(a);
                C(i+position-1,j+position-1)=max(b) + abs(min(b)); 
                bwC(i+position-1,j+position-1)=1;
            end
        end
        
    end
end






% figure,imshow(A);
% title('Original Image');
% figure,imshow(mat2gray(DA));
% title('Result Of DoOG');
% figure,imshow(bwC);
% title('Centerline');
% figure,imshow(C);
% title('Result Of Centerline detection');
% figure,imshow(imcomplement(Z));



% x=linspace(0,pi,500);
% y=sin(x);
% I=repmat(y,250,1);
% I=imrotate(I,-45);

