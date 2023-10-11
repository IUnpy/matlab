clc;
clear all;

TNR_dB=-10:0.1:10;
for i=1:201
    TNR(i)=10.^(TNR_dB(i)/10);
    middle(i)=-sqrt(TNR(i));
end
p_e=cdf('Normal',middle,0,1);
for i=1:201
    H(i)=p_e(i)*log2(1/p_e(i))+(1-p_e(i))*log2(1/(1-p_e(i)));
end
plot(TNR_dB,H,'-b');axis([-10,10,0,1]),grid on,xlabel('Tag to Noise Power Radio(dB)'),ylabel('Equivocation(bits)'),title('Equivocation to Adversary with Binary Symbols');