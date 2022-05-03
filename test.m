function out=test();
r=10;
c=15;
sz=randi([50,100],1,1);
s_x=randi([1,r],1,sz(1,1));
s_y=randi([1,c],1,sz(1,1));
IS_v=zeros(1,sz(1,1));
LS_v=zeros(1,sz(1,1));
for i = 1:1
    for j = 1:sz(1,1)
        x=s_x(i,j);
        y=s_y(i,j);
        IS_v(i,j)=3;
        LS_v(i,j)=1;
    end    
end

MI_v= mean(IS_v);

stdI_v=std(IS_v)
I_v=MI_v-stdI_v
L_v=mean(LS_v)