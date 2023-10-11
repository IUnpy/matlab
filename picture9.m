clc
clear,close all

ss_1=1;tt_1=0;
ss_2=0.999;tt_2=0.001;
ss_3=0.99;tt_3=0.01;
ss_4=0.95;tt_4=0.05;
SNR_dB=18.9;
n=100000;
h=(1/sqrt(2))*( randn(1,n) + 1i*randn(1,n)); %瑞利信道，两个分量均值为0同方差
sigma = sqrt(0.5*10.^(-SNR_dB/10)); % 噪声的sigma需要由信道的信噪比决定，这里是平均信噪比18.9
w=sigma*randn(1,n);%标准正态分布前×一个sigma就得到一般的正态分布
SNR=10.^(SNR_dB/10);
N0=1/SNR;
for i=1:n
    gama(i)=((abs(h(i))).^2)/N0;
    MIR_1(i)=(ss_1*gama(i))/(tt_1*gama(i)+1);
    MIR_2(i)=(ss_2*gama(i))/(tt_2*gama(i)+1);
    MIR_3(i)=(ss_3*gama(i))/(tt_3*gama(i)+1);
    MIR_4(i)=(ss_4*gama(i))/(tt_4*gama(i)+1);
    MIR_dB_1(i)=10*log10(MIR_1(i));%经常会有dB和倍数之间换算来换算去，很正常啦！
    MIR_dB_2(i)=10*log10(MIR_2(i));
    MIR_dB_3(i)=10*log10(MIR_3(i));
    MIR_dB_4(i)=10*log10(MIR_4(i));
end
[pdf_1,xi] = ksdensity(MIR_dB_1);
[pdf_2,xi] = ksdensity(MIR_dB_2);
[pdf_3,xi] = ksdensity(MIR_dB_3);
[pdf_4,xi] = ksdensity(MIR_dB_4);
plot(xi,pdf_1,'-b',xi,pdf_2,'-r',xi,pdf_3,'-g',xi,pdf_4,'-y');axis([-5,30,0,0.09]);grid on,xlabel('Message to Interference Radio(dB)'),ylabel('Probability Density'),legend('ρs^2=1','ρs^2=0.999','ρs^2=0.99','ρs^2=0.95'),title('Distribution of MIR(γ0=6dB,Pout=0.05)');

% histogram(MIR_dB_1,'Normalization','probability');
% hold on;
% histogram(MIR_dB_2,'Normalization','probability');
% hold on;
% histogram(MIR_dB_3,'Normalization','probability');
% hold on;
% histogram(MIR_dB_4,'Normalization','probability');
% hold off;

