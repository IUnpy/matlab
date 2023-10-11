clc
clear all
syms x;

% f=exp(-x^2/2);
% f1=int(f,x,[-inf x])-sqrt(2*pi)*0.99;
% s=solve(f1,x);
% disp(s);
y=sqrt(2)*erfinv(2*0.99-1);
disp(y);