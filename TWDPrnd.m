function TWDP = TWDPrnd(N,m)
TWDP =zeros(N,1);
K=1;
while K<N+1
    X =10*rand;
    Y = 0.19*rand;
    if Y<2*m^m*X^(2*m-1)*exp(-m*X^2)/gamma(m)
        TWDP(K,1) =X;
        K = K+1;
    end
end
end
%设PDF为f(x)。首先生成一个均匀分布随机数X∼Uni(xmin,xmax)
%独立的生成另一个均匀分布随机数Y∼Uni(ymin,ymax)
%如果Y≤f(X)，则返回X，否则回到第1步
