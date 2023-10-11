clc;
clear all;

M=100;
sigma_x=0.1:1:1000;
for i=1:1000
    num=0;
    for a=1:1000
    %生成P_1到P_3
    P_1=sigma_x(i)*randn(M,5);
    P_2=sigma_x(i)*randn(M,5);
    P_3=sigma_x(i)*randn(M,5);
    P_1_H=P_1';
    P_2_H=P_2';
    P_3_H=P_3';
    %生成h
    sigma_h=0.001;
    deta_h_1=sigma_h*randn(5,1);
    deta_h_2=sigma_h*randn(5,1);
    deta_h_3=sigma_h*randn(5,1);
    h_1=zeros(5,1);
    h_2=zeros(5,1);
    h_3=zeros(5,1);
    for j=1:5
        if j==1
            h_1(j)=1+deta_h_1(j);
            h_2(j)=1+deta_h_2(j);
            h_3(j)=1+deta_h_3(j);
        else
            h_1(j)=0.01+deta_h_1(j);
            h_2(j)=0.01+deta_h_2(j);
            h_3(j)=0.01+deta_h_3(j);
        end
    end
    %生成v
    SNR_dB=30;
    sigma_v= sqrt(0.5*10.^(-SNR_dB/10)); % SNR=30dB，
    v_1=sigma_v*randn(100,1);
    v_2=sigma_v*randn(100,1);
    v_3=sigma_v*randn(100,1);
    Y_1=P_1*h_1+v_1;
    Y_2=P_2*h_2+v_2;
    Y_3=P_3*h_3+v_3;
    %开始计算
    h_1_opt=inv(P_1_H*P_1)*P_1_H*Y_1;
    h_2_opt=inv(P_2_H*P_2)*P_2_H*Y_2;
    d=h_2_opt-h_1_opt;
    d_H=d';
    judge=d_H*P_3_H*P_3*d+d_H*(P_3_H*v_3)+(P_3_H*v_3)'*d;
    if judge<0
        num=num+1;
    end
    end
    Pe(i)=num/1000;
end
loglog(sigma_x,Pe);