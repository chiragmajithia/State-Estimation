function [ mu,sigma ] = getMVG(data)
data = double(data);
K = size(data,2);
sprintf('Dimension of gaussian is same as dimension of data %d', K);
mu = zeros(K,1);
sigma = zeros(K,K);
mu = mean(data)';
sigma = cov(data,1) ;
end

