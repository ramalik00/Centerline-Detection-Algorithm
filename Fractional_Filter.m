function [M]=Fractional_Filter(n)
 
a=0.85;
alpha=0.08;
d=2*(a^alpha);
c(1)=gammainc(a,alpha)/d;

for i=2:n
    c(i)=(gammainc(i*a,alpha)-gammainc((i-2)*a,alpha))/d;
end

c(n+1)=(gammainc(n*a,alpha)-gammainc((n-1)*a,alpha))/d;

t1=c+flip(c);

M=zeros(n+1);
M((n/2)+1,:)=t1;
M=M+transpose(M)+diag(t1);
for i=1:n+1
     M(n+2-i,i)=M(n+2-i,i)+t1(i);
end
s=sum(sum(M));

M=M/s;
end
