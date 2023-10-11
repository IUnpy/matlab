clc;
clear all;

a=0.995;
x=10:20;
sigma_h=1;
sigma_u=(1-a*a)*sigma_h;
ss=0.995;
tt=1-ss;
L_1=1024;
L_2=4096;
L_3=8192;
n=1000;
h=zeros(1,n);
h(1)=(1/sqrt(2))*( randn(1,1) + 1i*randn(1,1)); 
u=sqrt(sigma_u)*randn(1,n);
for i=2:n
    h(i)=a*h(i-1)+u(i);
end
for i=1:11
    for j=1:n
        N0(i)=1/(10^(((10+i-1))/10));
        gama(j)=((abs(h(j))).^2)/N0(i);
        sigma_v_1(j)=sqrt(L_1/(tt*gama(j)));
        sigma_v_2(j)=sqrt(L_2/(tt*gama(j)));
        sigma_v_3(j)=sqrt(L_3/(tt*gama(j)));
        tao_0_1(j)=sqrt(2)*erfinv(2*0.99-1)*sigma_v_1(j);%用反误差函数解方程
        tao_0_2(j)=sqrt(2)*erfinv(2*0.99-1)*sigma_v_2(j);
        tao_0_3(j)=sqrt(2)*erfinv(2*0.99-1)*sigma_v_3(j);
        middle_1(i,j)=(tao_0_1(j)-L_1)/sigma_v_1(j);
        middle_2(i,j)=(tao_0_2(j)-L_2)/sigma_v_2(j);
        middle_3(i,j)=(tao_0_3(j)-L_3)/sigma_v_3(j);
    end
end
for i=1:11
    p_1(i,:)=1-cdf('Normal',middle_1(i,:),0,1);
    p_2(i,:)=1-cdf('Normal',middle_2(i,:),0,1);
    p_3(i,:)=1-cdf('Normal',middle_3(i,:),0,1);
    P_1(i)=mean(p_1(i,:));
    P_2(i)=mean(p_2(i,:));
    P_3(i)=mean(p_3(i,:));
end
plot(x,P_1,'-b',x,P_2,'-.r',x,P_3,'--g');;axis([10,20,0,1]);grid on,xlabel('SNR(dB)'),ylabel('Probability'),legend('L=1024','L=4096','L=8192'),title('Authentication Probabilities for Time-Varying channel,a=0.995,ρs^2=0.995');        
        
    