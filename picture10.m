clc
clear,close all;
gama_0_3dB=2;%dB形式要换成倍数形式
gama_0_6dB=4;
gama_0_9dB=8;
ss=0.95:0.001:1;
tt=zeros(1,51);
for i=1:51
    tt(i)=1-ss(i);
end
gama_3dB=-(gama_0_3dB/(1-gama_0_3dB*0))/log(1-0.05);%ss=1的时候P_out=0.05能计算出来gama_
gama_6dB=-(gama_0_6dB/(1-gama_0_6dB*0))/log(1-0.05);
gama_9dB=-(gama_0_9dB/(1-gama_0_9dB*0))/log(1-0.05);
for i=1:51
    gama_m_3dB(i)=gama_0_3dB/(ss(i)-gama_0_3dB*tt(i));
    gama_m_6dB(i)=gama_0_6dB/(ss(i)-gama_0_6dB*tt(i));
    gama_m_9dB(i)=gama_0_9dB/(ss(i)-gama_0_9dB*tt(i));
    P_out_3dB(i)=1-exp(-gama_m_3dB(i)/gama_3dB);
    P_out_6dB(i)=1-exp(-gama_m_6dB(i)/gama_6dB);
    P_out_9dB(i)=1-exp(-gama_m_9dB(i)/gama_9dB);
end
plot(ss,P_out_3dB,'-.r',ss,P_out_6dB,'--g',ss,P_out_9dB,'-b');axis([0.95,1,0,0.1]);grid on,xlabel('Message Power(ρs^2)'),ylabel('Outage Probability'),legend('γ0=3dB','γ0=6dB','γ0=9dB'),title('Outage Probabilities for varying ρs^2');