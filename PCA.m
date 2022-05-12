function [Pe,De]= PCA(f)
n=5;
Kx=zeros(n,n);
Ky=zeros(n,n);
for i = 1:n
    for j = 1:n
        Kx(i,j)=j;
        Ky(i,j)=i;
    end    
end
[r,c]=size(f);
Xc=zeros(r,c);
Yc=zeros(r,c);
Xv=zeros(r,c);
Yv=zeros(r,c);
Cov=zeros(r,c);
% Calculating Weighted mean for each pixel
for x=1:r
    for y=1:c
        numx=0;
        numy=0;
        den=0;
        for i=1:n
            for j=1:n
                nx =x+i- (n+1)/2;
                ny=y+j- (n+1)/2;
                if nx > r
                    continue;
                end
                if nx<=0
                    continue;
                end
                if ny > c
                    continue;
                end
                if ny<=0
                    continue;
                end    
                numx=numx+Kx(i,j)*f(nx,ny);
                numy=numy+Ky(i,j)*f(nx,ny);
                den=den+f(nx,ny);
            end
        end
        Xc(x,y)=numx/den;
        Yc(x,y)=numy/den;
    end    
end
% Calculating Variance for each pixel
for x=1:r
    for y=1:c
        for i=1:n
            for j=1:n
                nx =x+i- (n+1)/2;
                ny=y+j- (n+1)/2;
                if nx > r
                    continue;
                end
                if nx<=0
                    continue;
                end
                if ny > c
                    continue;
                end
                if ny<=0
                    continue;
                end    
                Xv(x,y)=Xv(x,y)+(Kx(i,j)-Xc(x,y))*(Kx(i,j)-Xc(x,y))*f(nx,ny);
                Yv(x,y)=Yv(x,y)+(Ky(i,j)-Yc(x,y))*(Ky(i,j)-Yc(x,y))*f(nx,ny);
                Cov(x,y)=Cov(x,y)+(Ky(i,j)-Yc(x,y))*(Kx(i,j)-Xc(x,y))*f(nx,ny);
            end
        end
        
    end    
end
%Principal Eigen Values
Pe=zeros(r,c);
%Difference Eigen Values
De=zeros(r,c);
for x=1:r
    for y=1:c
     M=zeros(2,2);
     M(1,1)=Xv(x,y);
     M(1,2)=Cov(x,y);
     M(2,1)=Cov(x,y);
     M(2,2)=Yv(x,y);
     e=eig(M);
     e=sort(e,'descend');
     Pe(x,y)=e(1);
     De(x,y)=e(1)-e(2);
    end
end    

