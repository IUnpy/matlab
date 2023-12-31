clc
clear,close all

x=0.8:0.0105:1;
y_1=[0.9,0.899,0.895,0.894,0.885,0.88,0.86,0.84,0.82,0.81,0.79,0.76,0.72,0.66,0.59,0.49,0.35,0.18,0.01,0];
y_2=[0.98,0.975,0.97,0.95,0.93,0.92,0.89,0.81,0.71,0.58,0.39,0.16,0.01,0,0,0,0,0,0,0];
y_3=[0.68,0.59,0.5,0.39,0.25,0.13,0.05,0.01,0,0,0,0,0,0,0,0,0,0,0,0];
y_4=[0.92,0.91,0.905,0.903,0.9,0.89,0.88,0.87,0.85,0.82,0.8,0.78,0.74,0.7,0.62,0.54,0.4,0.22,0.06,0];
subplot(1,2,1);plot(x,y_1,'-bd',x,y_2,'-rs');axis([0.8,1,0,1]);xlabel('β');ylabel('Probability of Authentication');
subplot(1,2,2);plot(x,y_4,'-bd',x,y_3,'-rs');axis([0.8,1,0,1]);xlabel('β');ylabel('Probability of Authentication');legend('Auth-SLO','Auth-SUP');