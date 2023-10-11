clc
clear,close all
t_value=[-1.15 -0.453 0.453 1.15] ;
t_p=[0.168 0.332 0.332 0.168];
t_k_6=randsrc(1,1000,[-1.15 -0.453 0.453 1.15; 0.168 0.332 0.332 0.168]);%生成样本值按概率分布的1000点序列
t_k_7=randsrc(1,1000,[-0.168 1.667;0.5 0.5]);
t_k_8=randsrc(1,1000,[-0.168 1.114;0.5 0.5]);
SNR_dB_6=0;SNR_dB_7=0;SNR_dB_8=-10;
sigma_6= sqrt(0.5*10.^(-SNR_dB_6/10));
sigma_7= sqrt(0.5*10.^(-SNR_dB_7/10)); 
sigma_8= sqrt(0.5*10.^(-SNR_dB_8/10));
w_k_6=sigma_6*randn(1,1000);%合法噪声，假设为标准高斯随机分布
w_k_7=sigma_7*randn(1,1000);
w_k_8=sigma_8*randn(1,1000);
y_k_6=t_k_6+w_k_6;%1000点序列加噪声，高斯白
y_k_7=t_k_7+w_k_7;
y_k_8=t_k_8+w_k_8;
mean_6=mean(y_k_6);mean_7=mean(y_k_7);mean_8=mean(y_k_8);
var_6=var(y_k_6);var_7=var(y_k_7);var_8=var(y_k_8);
x=-10:0.1:10;
y_n_6=cdf('Normal',x,mean_6,sqrt(var_6));%生成和观测数据同均值方差的正态分布的累积分布函数，注意cdf需要的是标准差而非方差
y_n_7=cdf('Normal',x,mean_7,sqrt(var_7));
y_n_8=cdf('Normal',x,mean_8,sqrt(var_8));
[h_6,p_6]=lillietest(y_k_6,0.01);%拟合优度检验
[h_7,p_7]=lillietest(y_k_7,0.01);
[h_8,p_8]=lillietest(y_k_8,0.01);
%%%%%%%%%%%%%%% picture6 %%%%%%%%%%%%%
subplot(2,2,1),picture_o_6=cdfplot(y_k_6);%观测数据的累积分布函数
set(picture_o_6,'color','red');
hold on;
plot(x,y_n_6,'--b'),axis([-10,10,0,1]),grid on,xlabel('Sample'),ylabel('CDF'),legend('Observed Distribution','Normal Distribution'),title('Noise CDFs with TNR=0dB,2-bit tag');
hold off;
%%%%%%%%%%%%%%% picture7 %%%%%%%%%%%%%
subplot(2,2,2),picture_o_7=cdfplot(y_k_7);%观测数据的累积分布函数
set(picture_o_7,'color','red');
hold on;
plot(x,y_n_7,'--b'),axis([-10,10,0,1]),grid on,xlabel('Sample'),ylabel('CDF'),legend('Observed Distribution','Normal Distribution'),title('Noise CDFs with TNR=0dB,1-bit tag');
hold off;
%%%%%%%%%%%%%%% picture8 %%%%%%%%%%%%%
subplot(2,2,3),picture_o_8=cdfplot(y_k_8);%观测数据的累积分布函数
set(picture_o_8,'color','red');
hold on;
plot(x,y_n_8,'--b'),axis([-10,10,0,1]),grid on,xlabel('Sample'),ylabel('CDF'),legend('Observed Distribution','Normal Distribution'),title('Noise CDFs with TNR=-10dB,1-bit tag');
hold off;

