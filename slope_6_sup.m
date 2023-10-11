clc
clear,close all

tt=0.1^2;ss=1-tt;
SNR_dB=0:2:30;
m=1.5;
N=10000;
h=TWDPrnd(N,m);
L=2000;
for i=1:16
    SNR(i)=10^(SNR_dB(i)/10);
    N0(i)=100/(SNR(i)-1);
end
for j=1:16
    for i=1:N
        gama(i)=((abs(h(i))).^2)/N0(j);
        sigma_v(i)=sqrt(L/(tt*gama(i)));
        tao_0(i)=sqrt(2)*erfinv(2*0.99-1)*sigma_v(i);%用反误差函数解方程
        middle_1(j,i)=(tao_0(i)-L)/sigma_v(i);
    end
end
for i=1:16
    p_1(i,:)=1-cdf('Normal',middle_1(i,:),0,1);
    P_1(i)=mean(p_1(i,:));
end
subplot(1,2,1);plot(SNR_dB,P_1)