clc;
clear all;

M=100;
sigma_x=0.1:1:100;
%I=ones(M,M);
I=rand(M);
for i=1:100
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
    P=zeros(3*M,3*M);
    B=zeros(3*M,1);
    V=zeros(3*M,1);
    d=h_2-h_1;
    X=inv(P_2'*P_2+P_3'*P_3);
    XX=inv(P_1'*P_1+P_3'*P_3);
    %开始生成B
    B1=zeros(M,1);
    B2=P_2*d;
    B3=zeros(M,1);
    for p=1:M
        B(p,1)=B1(p,1);
        B(p+M,1)=B2(p,1);
        B(p+2*M,1)=B3(p,1);
    end
    %开始生成V
    for p=1:M
         V(p,1)=v_1(p,1);
         V(p+M,1)=v_2(p,1);
         V(p+2*M,1)=v_3(p,1);
    end
    %开始生成P
    P1=-(I-P_1*XX*P_1_H);
    P2=zeros(M,M);
    P3=P_1*XX*P_3_H;
    P4=zeros(M,M);
    P5=I-P_2*X*P_2_H;
    P6=P_2*XX*P_3_H;
    P7=P_3*XX*P_1_H;
    P8=-P_3*XX*P_2_H;
    P9=P_3*(X-XX)*P_3_H;
    for p=1:M
        for q=1:M
            P(p,q)=P1(p,q);
            P(p,q+M)=P2(p,q);
            P(p,q+2*M)=P3(p,q);
            P(p+M,q)=P4(p,q);
            P(p+M,q+M)=P5(p,q);
            P(p+M,q+2*M)=P6(p,q);
            P(p+2*M,q)=P7(p,q);
            P(p+2*M,q+M)=P8(p,q);
            P(p+2*M,q+2*M)=P9(p,q);
        end
    end
    judge=(V-B)'*P*(V-B);
    if judge<0
        num=num+1;
    end
    end
    Pe(i)=num/1000;
end
loglog(sigma_x,Pe);

