clc;
clear all;

beta=0.9;
SNR_dB=-10:5:30;
SNR_dB_2=15;
SNR_2=10.^(SNR_dB_2/10);
beta_2=0.75:0.025:1;
SNR=10.^(SNR_dB/10);
for i=1:9
        gama_k_1(i)=(1-beta)^2*SNR(i);
end
for i=1:11
        gama_k_2(i)=(1-beta_2(i))^2*SNR_2;
end
p_e_1=cdf('Normal',gama_k_1,0,1);
p_e_2=cdf('Normal',gama_k_2,0,1);
for i=1:9
    H_1(i)=p_e_1(i)*log2(1/p_e_1(i))+(1-p_e_1(i))*log2(1/(1-p_e_1(i)));
end
for i=1:11
    H_2(i)=p_e_2(i)*log2(1/p_e_2(i))+(1-p_e_2(i))*log2(1/(1-p_e_2(i)));
end
subplot(2,1,1);plot(SNR_dB,H_1,'-bd');axis([-10,30,0,1]),grid on,xlabel('SNR(dB)'),ylabel('Equivocation(bits)'),title('a');
subplot(2,1,2);plot(beta_2,H_2,'-bd');axis([0.75,1,0,1]),grid on,xlabel('β'),ylabel('Equivocation(bits)'),title('b');
