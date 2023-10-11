clc
clear,close all

tt=0.1^2;ss=1-tt;
beta=0.9;algh=sqrt(2-beta^2);
SNR_dB=0:2:30;
FA=0.01;
m=1.5;
N=1;
fc=2*10^9;
c=3*10^8;
lamda=c/fc;
d=100;
l=lamda/4*pi*d;
h=TWDPrnd(N,m); %Nakagami-m fading channel

for i=1:16
    SNR(i)=10^(SNR_dB(i)/10);
    N0(i)=1/SNR(i);
    for j=1:N
        %gama_1(i,j)=((abs(h(j))).^2)/N0(i);
        T(i,j)=(h(j))^2*(algh^2-beta^2);
        A_1=sqrt(2*T(i,j)^2/N0(i));
        B_1=sqrt(2*log(1/(2*FA)));
        syms x ;syms s;
        I_process_1=@(x,s) exp(-A_1*x.*sin(s));
%         I_less_1=int(I_process_1,s,-pi/2,pi/2);
        I_less_1 = integral2(I_process_1,-pi,pi,-pi,pi);
        I_1=I_less_1/(2*pi);
        A_2=sqrt(T(i,j)^2/N0(i));
        B_2=sqrt(4*log(1/(2*FA)));
        I_process_2=@(x,s)exp(-A_2*x.*sin(s));
%         I_less_2=int(I_process_2,s,-pi/2,pi/2);
        I_less_2 = integral2(I_process_2,-pi,pi,-pi,pi);
        I_2=I_less_2/(2*pi);
        Q_process_1=x*exp(-(x^2+A_1^2)/2)*I_1;
        Q_process_2=x*exp(-(x^2+A_2^2)/2)*I_2;
        Q_1=int(Q_process_1,x,B_1,inf);
        Q_2=int(Q_process_2,x,B_2,inf);
        P_PD(i,j)=Q_1-0.5*exp(log(1/(2*FA))-T(i,j)^2/(2*N0(i)))*Q_2;
    end
end
syms g;
for i = 1:16
    %P_PD_process(i) = mean(P_PD(i,:));
    f_gama=P_PD(i,1)*(1/(g*gamma(m)))*(m*g/SNR(i))^m*exp(-m*g/SNR(i));
    P_D(i)=int(f_gama,g,0,inf);
end

plot(SNR_dB,P_D);