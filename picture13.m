clc
clear,close all

ss_1=0.985;tt_1=0.015;
ss_2=0.995;tt_2=0.005;
ss_3=0.999;tt_3=0.001;
%syms tao [1 1000];
L=30:200:1200;
n=1000;
gama_0_dB=6;
gama_0=4;
P_out=0.05;
gama_=-gama_0/log(1-P_out);
N0=1/gama_;
h=(1/sqrt(2))*( randn(1,n) + 1i*randn(1,n));
for j=1:6
    for i=1:n
        gama(i)=((abs(h(i))).^2)/N0;
        sigma_v_1(i)=sqrt(L(j)/(tt_1*gama(i)));
        sigma_v_2(i)=sqrt(L(j)/(tt_2*gama(i)));
        sigma_v_3(i)=sqrt(L(j)/(tt_3*gama(i)));
        tao_0_1(i)=sqrt(2)*erfinv(2*0.99-1)*sigma_v_1(i);%用反误差函数解方程
        tao_0_2(i)=sqrt(2)*erfinv(2*0.99-1)*sigma_v_2(i);
        tao_0_3(i)=sqrt(2)*erfinv(2*0.99-1)*sigma_v_3(i);
%         tao_0_1(i)=solve((1/2)*(1+erf((tao(i)/sigma_v_1(i))/sqrt(2)))-0.99,tao(i));
%         tao_0_2(i)=solve((1/2)*(1+erf((tao(i)/sigma_v_2(i))/sqrt(2)))-0.99,tao(i));
%         tao_0_3(i)=solve((1/2)*(1+erf((tao(i)/sigma_v_3(i))/sqrt(2)))-0.99,tao(i));
        middle_1(j,i)=(tao_0_1(i)-L(j))/sigma_v_1(i);
        middle_2(j,i)=(tao_0_2(i)-L(j))/sigma_v_2(i);
        middle_3(j,i)=(tao_0_3(i)-L(j))/sigma_v_3(i);
    end
end
for i=1:6
    p_1(i,:)=1-cdf('Normal',middle_1(i,:),0,1);
    p_2(i,:)=1-cdf('Normal',middle_2(i,:),0,1);
    p_3(i,:)=1-cdf('Normal',middle_3(i,:),0,1);
    P_1(i)=mean(p_1(i,:));
    P_2(i)=mean(p_2(i,:));
    P_3(i)=mean(p_3(i,:));
end
plot(L,P_1,'-b',L,P_2,'-.r',L,P_3,'--g');;axis([0,1200,0,1]);grid on,xlabel('Tag Length'),ylabel('Probability of Authentication'),legend('Pd,ρs^2=0.985','Pd,ρs^2=0.995','Pd,ρs^2=0.999'),title('Authentication Probabilities for varying tag Length');