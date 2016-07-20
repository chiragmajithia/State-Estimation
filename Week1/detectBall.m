% Robotics: Estimation and Learning 
% WEEK 1
% 
% Complete this function following the instruction. 
function [segI, loc] = detectBall(I)
% function [segI, loc] = detectBall(I)
%
% INPUT
% I       120x160x3 numerial array 
%
% OUTPUT
% segI    120x160 numeric array
% loc     1x2 or 2x1 numeric array 


addpath('./scripts')
I_ball = zeros(size(I,1),size(I,2));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Hard code your learned model parameters here

%data = [R,G,B];
%data = [H,S,V]
%data = H
%[mu,sig] = getMVG(data);
mu = [147.6509;
      143.4414;
       62.8310];
sig = [224.2974  139.2822 -231.6300;
       139.2822  139.3513 -179.0308;
      -231.6300 -179.0308  372.4888];
thres = g(mu,mu,sig)*0.15

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Find ball-color pixels using your model
% 
for i = 1 : size(I,1)
    for j = 1 : size(I,2)
            val = double([I(i,j,1),I(i,j,2),I(i,j,3)]');
            I_ball(i,j) = g(val,mu,sig) > thres;
    end
end
%close all, figure(1),subplot(1,2,1),imshow(I),subplot(1,2,2),imshow(I_ball)

segI = false(size(I_ball));
CC = bwconncomp(I_ball);
numPixels = cellfun(@numel,CC.PixelIdxList);
[biggest,idx] = max(numPixels);
segI(CC.PixelIdxList{idx}) = true; 

% show the centroid
% http://www.mathworks.com/help/images/ref/regionprops.html
stats = regionprops(CC,'Centroid','MajorAxisLength','MinorAxisLength');
loc = stats(idx).Centroid;
%plot(loc(1), loc(2),'r+');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do more processing to segment out the right cluster of pixels.
% You may use the following functions.
%   bwconncomp
%   regionprops
% Please see example_bw.m if you need an example code.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Compute the location of the ball center
%

% segI = 
% loc = 
% 
% Note: In this assigment, the center of the segmented ball area will be considered for grading. 
% (You don't need to consider the whole ball shape if the ball is occluded.)

end
