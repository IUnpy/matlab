clc
clear,close all

tt=0.016^2;
ss=1-tt;
L=200:200:2000;
n=1000;
gama_0_dB=6;
gama_0=4;
P_out=0.05;
gama_=-gama_0/log(1-P_out);
N0=0.8/gama_;
m=1.5;
h=TWDPrnd(n,m);
for j=1:10
    for i=1:n
        gama(i)=((abs(h(i))).^2)/N0;
        sigma_v_1(i)=sqrt(L(j)/(tt*gama(i)));
        tao_0_1(i)=sqrt(2)*erfinv(2*0.99-1)*sigma_v_1(i);%用反误差函数解方程
        middle_1(j,i)=(tao_0_1(i)-L(j))/sigma_v_1(i);
    end
end
for i=1:10
    p_1(i,:)=1-cdf('Normal',middle_1(i,:),0,1);
    P_1(i)=mean(p_1(i,:));
end
P_2=[0.801,0.803,0.805,0.799,0.802,0.8,0.797,0.802,0.8,0.796];
plot(L,P_1,'-rd',L,P_2,'-bs');axis([200,2000,0.1,1]);grid on,xlabel('L'),ylabel('Probability of Authentication'),legend('Auth-SUP','Auth-SLO');