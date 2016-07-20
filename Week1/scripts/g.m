function [ p ] = g( X,mu,sigma )
	p =	mvnpdf(X,mu,sigma);
end
