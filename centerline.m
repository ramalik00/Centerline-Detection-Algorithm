function out=centerline()
% Initial File Although not used


A=imread('retinal1.jpg');
A=rgb2gray(A);
A=im2double(A);
B=A;
A=imcomplement(A);
[r c]=size(A);
imshow(A);
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
%figure,imshow(A+C);
%Horizontal
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
        

%figure,imshow(A+C2);
Im_H=A+C2;
Im_V=A+C;
%imwrite(A+C2,'H_centerline_before.jpg')
% Diagonal direction
 vf_D=[0 0 -1 0 0 0 0;0 -2 0 -2 0 0 0;-1 0 -4 0 0 0 0;....
     0 -2 0 0 0 2 0;0 0 0 0 4 0 1;0 0 0 2 0 2 0;0 0 0 0 1 0 0];
 [m n]=size(vf_D);

[r c]=size(A);
O=zeros(r,c);
C=zeros(r,c);
Z=zeros(r,c);
fm=floor(m/2);
fn=floor(n/2);
for i=ceil(m/2):r-fm
    for j=ceil(n/2):c-fn
        subimg=A(i-fm:i+fm,j-fn:j+fn);
        O(i,j)=sum(sum(vf_D.*subimg));
    end
end




OO=mat2gray(O);
figure,imshow(OO);
title('Result Of DoOG');
% figure,imshow(C);
% title('Centerline');

for i=1:r
    for j=1:c
        lenb=4;
        for step=0:3
            if i+step <=r & j+step <=c
                b(step+1)=O(i+step,j+step);
            else
                lenb=step;
                break;
            end
        end
        
        % if lenb=4 then t is of length 4 otherwise
        % length of t is less than 4 and in that case we don't
        % search for specific combination of signs.
        if lenb==4;
            Z(i,j)=1;
            flag=0;
            % perform the search for the local maxima in the
            % underlying image.
            adv=mean(b);
            if b(2)>0 & b(3)<0
                if b(1)>0 & ( b(4)<0 | adv>0 )
                    flag=1;
                end
                if adv<0 & b(4)<0
                    flag=1
                end
            end
            
            if flag==1
                for step=0:3
                    a(step+1)=A(i+step,j+step);
                end
                [value position]=max(a);
                C(i+position-1,j+position-1)=1;
            end
              
        end
        
    end
end

Im_D= A+C
figure,imshow(A+C);
title('Result Of Centerline detection');

% Step 2
std_H=double(std(Im_H(:)));
mean_H=mean(Im_H(:));
alpha=0.0000001;
Im_H_T=mean_H - alpha*(std_H);
for i = 1:r
    for j = 1:c
        if C2(i,j)== 0 & Im_H(i,j) >= Im_H_T
            C2(i,j)=1;
        end    
    end
end    
dj_H=DJSet(r*c);
for i = 2:r-1
    for j = 2:c-1
        if C2(i,j)==1 & C2(i+1,j)==1
            dj_H.union(c*(i-1)+j ,c*(i)+j);
        end 
        if C2(i,j)==1 & C2(i,j+1)==1
            dj_H.union(c*(i-1)+j ,c*(i-1)+j+1);
        end
        if C2(i,j)==1 & C2(i,j-1)==1
            dj_H.union(c*(i-1)+j ,c*(i-1)+j-1);
        end
        if C2(i,j)==1 & C2(i-1,j)==1
            dj_H.union(c*(i-1)+j ,c*(i-2)+j);
        end
        
    end    
end
min_points=2;
for i = 1:r
    for j = 1:c
        u=dj_H.root(c*(i-1)+j);
        %fprintf('%d ',dj_H.size(u));
        if dj_H.size(u) > min_points
            C2(i,j)=1;
        end  
    end 
    %fprintf('\n');
end

figure,imshow(A+C2);

%figure,imshow(A+C2);
%title('Result Of Centerline detection in horizontal direction');
%imwrite(A+C2,'H_centerline_after.jpg')
           

    
        
    



        