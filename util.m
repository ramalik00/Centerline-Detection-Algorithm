function [C_V,C_H,C_45,C_135]=util(A)
[C_V,V_DOOG]=vertical(A);
[C_H,H_DOOG]=horizontal(A);
[C_45,d45_DOOG]=diag45(A);
[C_135,d135_DOOG]=diag135(A);
[C_V,Len_V]=RegionGrowing(C_V,A);
[C_H,Len_H]=RegionGrowing(C_H,A);
[C_45,Len_45]=RegionGrowing(C_45,A);
[C_135,Len_135]=RegionGrowing(C_135,A);
[r,c]=size(C_H);
A=rgb2gray(A);
A=im2double(A);
IC_V=A+C_V;
IC_H=A+C_H;
IC_45=A+C_45;
IC_135=A+C_135;

                                                                                                                              
% For Horizontal
Avg_H=zeros(r,c);
Max_H=zeros(r,c);
I_H=zeros(r,c);
for i= 1:r
    for j = 1:c
        Avg_H(i,j)=IC_H(i,j);
        Max_H(i,j)=IC_H(i,j);
        points=1;
        if i+1<=r
            Avg_H(i,j)=Avg_H(i,j)+IC_H(i+1,j);
            Max_H(i,j)=max(Max_H(i,j),IC_H(i+1,j));
            points=points+1;
        end
            
        if j+1<=c 
            Avg_H(i,j)=Avg_H(i,j)+IC_H(i,j+1);
            Max_H(i,j)=max(Max_H(i,j),IC_H(i,j+1));
            points=points+1;
        end 
        if i-1>=1
            Avg_H(i,j)=Avg_H(i,j)+IC_H(i-1,j);
            Max_H(i,j)=max(Max_H(i,j),IC_H(i-1,j));
            points=points+1;
        end
        if j-1>=1 
            Avg_H(i,j)=Avg_H(i,j)+IC_H(i,j-1);
            Max_H(i,j)=max(Max_H(i,j),IC_H(i,j-1));
            points=points+1;
        end
        Avg_H(i,j)=Avg_H(i,j)/points;
        Temp=[Avg_H(i,j),Max_H(i,j)];
        I_H(i,j)=geomean(Temp);
    end
end




% For Vertical
Avg_V=zeros(r,c);
Max_V=zeros(r,c);
I_V=zeros(r,c);
for i= 1:r
    for j = 1:c
        Avg_V(i,j)=IC_V(i,j);
        Max_V(i,j)=IC_V(i,j);
        points=1;
        if i+1<=r
            Avg_V(i,j)=Avg_V(i,j)+IC_V(i+1,j);
            Max_V(i,j)=max(Max_V(i,j),IC_V(i+1,j));
            points=points+1;
        end
        if j+1<=c 
            Avg_V(i,j)=Avg_V(i,j)+IC_V(i,j+1);
            Max_V(i,j)=max(Max_V(i,j),IC_V(i,j+1));
            points=points+1;
        end 
        if i-1>=1
            Avg_V(i,j)=Avg_V(i,j)+IC_V(i-1,j);
            Max_V(i,j)=max(Max_V(i,j),IC_V(i-1,j));
            points=points+1;
        end
        if j-1>=1 
            Avg_V(i,j)=Avg_V(i,j)+IC_V(i,j-1);
            Max_V(i,j)=max(Max_V(i,j),IC_V(i,j-1));
            points=points+1;
        end
        Avg_V(i,j)=Avg_V(i,j)/points;
        Temp=[Avg_V(i,j),Max_V(i,j)];
        I_V(i,j)=geomean(Temp);
    end
end



% For 45
Avg_45=zeros(r,c);
Max_45=zeros(r,c);
I_45=zeros(r,c);
for i= 1:r
    for j = 1:c
        Avg_45(i,j)=IC_45(i,j);
        Max_45(i,j)=IC_45(i,j);
        points=1;
        if i+1<=r
            Avg_45(i,j)=Avg_45(i,j)+IC_45(i+1,j);
            Max_45(i,j)=max(Max_45(i,j),IC_45(i+1,j));
            points=points+1;
        end
        if j+1<=c 
            Avg_45(i,j)=Avg_45(i,j)+IC_45(i,j+1);
            Max_45(i,j)=max(Max_45(i,j),IC_45(i,j+1));
            points=points+1;
        end 
        if i-1>=1
            Avg_45(i,j)=Avg_45(i,j)+IC_45(i-1,j);
            Max_45(i,j)=max(Max_45(i,j),IC_45(i-1,j));
            points=points+1;
        end
        if j-1>=1 
            Avg_45(i,j)=Avg_45(i,j)+IC_45(i,j-1);
            Max_45(i,j)=max(Max_45(i,j),IC_45(i,j-1));
            points=points+1;
        end
        Avg_45(i,j)=Avg_45(i,j)/points;
        Temp=[Avg_45(i,j),Max_45(i,j)];
        I_45(i,j)=geomean(Temp);
    end
end



% For 135
Avg_135=zeros(r,c);
Max_135=zeros(r,c);
I_135=zeros(r,c);
for i= 1:r
    for j = 1:c
        Avg_135(i,j)=IC_135(i,j);
        Max_135(i,j)=IC_135(i,j);
        points=1;
        if i+1<=r
            Avg_135(i,j)=Avg_135(i,j)+IC_135(i+1,j);
            Max_135(i,j)=max(Max_135(i,j),IC_135(i+1,j));
            points=points+1;
        end
        if j+1<=c 
            Avg_135(i,j)=Avg_135(i,j)+IC_135(i,j+1);
            Max_135(i,j)=max(Max_135(i,j),IC_135(i,j+1));
            points=points+1;
        end 
        if i-1>=1
            Avg_135(i,j)=Avg_135(i,j)+IC_135(i-1,j);
            Max_135(i,j)=max(Max_135(i,j),IC_135(i-1,j));
            points=points+1;
        end
        if j-1>=1 
            Avg_135(i,j)=Avg_135(i,j)+IC_135(i,j-1);
            Max_135(i,j)=max(Max_135(i,j),IC_135(i,j-1));
            points=points+1;
        end
        Avg_135(i,j)=Avg_135(i,j)/points;
        Temp=[Avg_135(i,j),Max_135(i,j)];
        I_135(i,j)=geomean(Temp);
    end
end
%Normalizing diagonal lengths 
sqt2=sqrt(2);
for i= 1:r
    for j= 1:c
        Len_45(i,j)=Len_45(i,j)/sqt2;
        Len_135(i,j)=Len_135(i,j)/sqt2;
    end    
end    

% Calculating Reference values
%Vertical
sz=randi([50,100],1,1);
s_x=randi([1,r],1,sz(1,1));
s_y=randi([1,c],1,sz(1,1));
IS_v=zeros(1,sz(1,1));
LS_v=zeros(1,sz(1,1));
for i = 1:1
    for j = 1:sz(1,1)
        x=s_x(i,j);
        y=s_y(i,j);
        IS_v(i,j)=I_V(x,y);
        LS_v(i,j)=Len_V(x,y);
    end    
end    
MI_v= mean(IS_v);
stdI_v=std(IS_v);
Ix_V=MI_v-stdI_v;
L_V=mean(LS_v);

%Horizontal

IS_H=zeros(1,sz(1,1));
LS_H=zeros(1,sz(1,1));
for i = 1:1
    for j = 1:sz(1,1)
        x=s_x(i,j);
        y=s_y(i,j);
        IS_H(i,j)=I_H(x,y);
        LS_H(i,j)=Len_H(x,y);
    end    
end    
MI_H= mean(IS_H);
stdI_H=std(IS_H);
Ix_H=MI_H-stdI_H;
L_H=mean(LS_H);

%45
IS_45=zeros(1,sz(1,1));
LS_45=zeros(1,sz(1,1));
for i = 1:1
    for j = 1:sz(1,1)
        x=s_x(i,j);
        y=s_y(i,j);
        IS_45(i,j)=I_45(x,y);
        LS_45(i,j)=Len_45(x,y);
    end    
end    
MI_45= mean(IS_45);
stdI_45=std(IS_45);
Ix_45=MI_45-stdI_45;
L_45=mean(LS_45);

% 135

IS_135=zeros(1,sz(1,1));
LS_135=zeros(1,sz(1,1));
for i = 1:1
    for j = 1:sz(1,1)
        x=s_x(i,j);
        y=s_y(i,j);
        IS_135(i,j)=I_135(x,y);
        LS_135(i,j)=Len_135(x,y);
    end    
end    
MI_135= mean(IS_135);
stdI_135=std(IS_135);
Ix_135=MI_135-stdI_135;
L_135=mean(LS_135);
%Global Set
IS_g=cat(2,IS_v,IS_H,IS_45,IS_135);
LS_g=cat(2,LS_v,LS_H,LS_45,LS_135);
MI_g=mean(IS_g);
stdI_g=std(IS_g);
I_g=MI_g-stdI_g;
L_g=mean(LS_g);
Ix_V=max(Ix_V,I_g);
Ix_H=max(Ix_H,I_g);
Ix_45=max(Ix_45,I_g);
Ix_135=max(Ix_135,I_g);
L_V=max(L_V,L_g);
L_H=max(L_H,L_g);
L_45=max(L_45,L_g);
L_135=max(L_135,L_g);

%Validating Step
% For Vertical
I_V_T=Ix_V*sqrt(L_V);
for i = 1:r
    for j=1:c
        if C_V(i,j)==0
            continue
        else
            Curr_I=I_V(i,j);
            Curr_L=Len_V(i,j);
            if Curr_I*sqrt(Curr_L) >= I_V_T
                C_V(i,j)=1;
            end    
        end    
    end    
end    
% For Horizontal
I_H_T=Ix_H*sqrt(L_H);
for i = 1:r
    for j=1:c
        if C_H(i,j)==0
            continue
        else
            Curr_I=I_H(i,j);
            Curr_L=Len_H(i,j);
            if Curr_I*sqrt(Curr_L) >= I_H_T
                C_H(i,j)=1;
            end    
        end    
    end    
end    

% For 45 degree
I_45_T=Ix_45*sqrt(L_45);
for i = 1:r
    for j=1:c
        if C_45(i,j)==0
            continue
        else
            Curr_I=I_45(i,j);
            Curr_L=Len_45(i,j);
            if Curr_I*sqrt(Curr_L) >= I_45_T
                C_45(i,j)=1;
            end    
        end    
    end    
end  
% For 135 degree
I_135_T=Ix_135*sqrt(L_135);
for i = 1:r
    for j=1:c
        if C_135(i,j)==0
            continue
        else
            Curr_I=I_135(i,j);
            Curr_L=Len_135(i,j);
            if Curr_I*sqrt(Curr_L) >= I_135_T
                C_135(i,j)=1;
            end    
        end    
    end    
end 

%imwrite(C_H,'H_centerline.jpg');
%imwrite(C_V,'V_centerline.jpg');
%imwrite(C_45,'45_centerline.jpg');
%imwrite(C_135,'135_centerline.jpg');







