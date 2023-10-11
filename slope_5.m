clc
clear,close all

N=10000;
ss=0.95;tt=0.05;
beta=0.9;alph=sqrt(2-beta^2);
m1=1.5;
m2=0.5
% fc=2*10^9;
% c=3*10^8;
% lamda=c/fc;
% d=100;
% l=lamda/4*pi*d;
snr_dB=0:2:30;
h1=TWDPrnd(N,m1);
h2=TWDPrnd(N,m2);
for i=1:16
    snr_(i)=10^(snr_dB(i)/10);
    N0(i)=0.5/snr_(i);
    for j=1:N

        gama_1(i,j)=((abs(h1(j))).^2)/N0(i);
        gama_2(i,j)=((abs(h2(j))).^2)/N0(i);
    end
end
for i=1:16
    for j=1:N
    SINR_normal_1(i,j)=gama_1(i,j);   
    SINR_SUP_1(i,j)=ss*gama_1(i,j)/(tt*gama_1(i,j)+1);
    SINR_SLO_1(i,j)=gama_1(i,j);
    BER_normal_1_(i,j)=(1/2)*erfc(sqrt(SINR_normal_1(i,j)));
    BER_SUP_1_(i,j)=(1/2)*erfc(sqrt(SINR_SUP_1(i,j)));
    BER_SLO_1_(i,j)=(1/2)*erfc(sqrt(SINR_SLO_1(i,j)));
    SINR_normal_2(i,j)=gama_2(i,j);   
    SINR_SUP_2(i,j)=ss*gama_2(i,j)/(tt*gama_2(i,j)+1);
    SINR_SLO_2(i,j)=gama_2(i,j);
    BER_normal_2_(i,j)=(1/2)*erfc(sqrt(SINR_normal_2(i,j)));
    BER_SUP_2_(i,j)=(1/2)*erfc(sqrt(SINR_SUP_2(i,j)));
    BER_SLO_2_(i,j)=(1/2)*erfc(sqrt(SINR_SLO_2(i,j)));
    end
end
for i=1:16
    BER_normal_1(i)=mean(BER_normal_1_(i,:));
    BER_SUP_1(i)=mean(BER_SUP_1_(i,:));
    BER_SLO_1(i)=mean(BER_SLO_1_(i,:));
    BER_normal_2(i)=mean(BER_normal_2_(i,:));
    BER_SUP_2(i)=mean(BER_SUP_2_(i,:));
    BER_SLO_2(i)=mean(BER_SLO_2_(i,:));
end
subplot(1,2,1);
semilogy(snr_dB,BER_normal_1,'-k*');hold on;axis([0,30,10e-5,1]);grid on;xlabel('SNR(dB)'),ylabel('BER');
semilogy(snr_dB,BER_SUP_1,'-rd');hold on;
semilogy(snr_dB,BER_SLO_1,'-bs');hold on;legend('Normal','Auth-SUP','Auth-SLO');

subplot(1,2,2);
semilogy(snr_dB,BER_normal_1,'-k*');hold on;axis([0,30,10e-5,1]);grid on;xlabel('SNR(dB)'),ylabel('BER');
semilogy(snr_dB,BER_SUP_1,'-rd');hold on;
semilogy(snr_dB,BER_SLO_1,'-bs');hold on;legend('Normal','Auth-SUP','Auth-SLO');

semilogy(snr_dB,BER_normal_2,'-k*');hold on;
semilogy(snr_dB,BER_SUP_2,'-rd');hold on;
semilogy(snr_dB,BER_SLO_2,'-bs');hold on;legend('Normal','Auth-SUP','Auth-SLO');
