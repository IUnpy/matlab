clc
clear,close all

n=10000;
ss=0.9:0.001:1;
for i=1:101
    tt=1-ss;
end
gama_0_3dB=2;
gama_0_6dB=4;
gama_0_9dB=8;
P_out=0.05;
gama_3dB=(-gama_0_3dB)/log(1-P_out);
gama_6dB=(-gama_0_6dB)/log(1-P_out);
gama_9dB=(-gama_0_9dB)/log(1-P_out);  
h=(1/sqrt(2))*( randn(1,n) + 1i*randn(1,n)); %瑞利信道，两个分量均值为0同方差
N0_3dB=1/gama_3dB;%gama_是平均信噪比SNR=1/N0，所以N0=1/gama_
N0_6dB=1/gama_6dB;
N0_9dB=1/gama_9dB;
for i=1:n
    gama_3dB(i)=((abs(h(i))).^2)/N0_3dB;
    gama_6dB(i)=((abs(h(i))).^2)/N0_6dB;
    gama_9dB(i)=((abs(h(i))).^2)/N0_9dB;
    for j=1:101
        MIR_3dB(j,i)=(ss(j)*gama_3dB(i))/(tt(j)*gama_3dB(i)+1);
        MIR_6dB(j,i)=(ss(j)*gama_6dB(i))/(tt(j)*gama_6dB(i)+1);
        MIR_9dB(j,i)=(ss(j)*gama_9dB(i))/(tt(j)*gama_9dB(i)+1);
    end
end
for i=1:101
    for j=1:n
        BER_o_3dB(i,j)=(1/2)*erfc(sqrt(MIR_3dB(i,j)));
        BER_o_6dB(i,j)=(1/2)*erfc(sqrt(MIR_6dB(i,j)));
        BER_o_9dB(i,j)=(1/2)*erfc(sqrt(MIR_9dB(i,j)));
    end
end
for i=1:101
    BER_3dB(i)=mean(BER_o_3dB(i,:));
    BER_6dB(i)=mean(BER_o_6dB(i,:));
    BER_9dB(i)=mean(BER_o_9dB(i,:));
end
semilogy(ss,BER_3dB);hold on;semilogy(ss,BER_6dB);hold on;semilogy(ss,BER_9dB);
%plot(ss,BER_3dB,'-b',ss,BER_6dB,'-.r',ss,BER_9dB,'--g');;axis([0.9,1,0.001,0.01]);grid on,xlabel('Message Power(ρs^2)'),ylabel('BER'),legend('γ0=3dB','γ0=6dB','γ0=9dB'),title('Message BER for varying ρs^2');
