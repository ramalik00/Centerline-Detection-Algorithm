function [C2,Len]=regionGrowing(C2,A)
A=rgb2gray(A);
A=im2double(A);
B=A;
A=imcomplement(A);
Im= A+C2;
[r c]=size(A);

std_H=double(std(Im(:)));
mean_H=mean(Im(:));
alpha=0.000000001;
Im_T=mean_H - alpha*(std_H);
Len=zeros(r,c);
for i = 1:r
    for j = 1:c
        if C2(i,j)== 0 & Im(i,j) >= Im_T
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
min_points=max(dj_H.size)-1000;
min_points;
for i = 1:r
    for j = 1:c
        u=dj_H.root(c*(i-1)+j);
        if dj_H.size(u) > min_points
            C2(i,j)=1;
        end  
        Len(i,j)=dj_H.size(u);
    end 
    
end
