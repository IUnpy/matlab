clc
clear,close all

x=0:2:30;
y_1=[0,0,0,0.03,0.13,0.32,0.54,0.71,0.83,0.9,0.95,0.98,0.99,0.995,1,1];
y_2=[0,0,0,0,0.03,0.19,0.39,0.6,0.76,0.88,0.92,0.97,0.98,0.99,0.999,1];

plot(x,y_1,'-bd',x,y_2,'-rs');axis([0,30,0,1]);xlabel('SNR(dB)');ylabel('Probability of Authentication');legend('Auth-SLO','Auth-SUP');