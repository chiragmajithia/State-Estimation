function [H_sample,S_sample,V_sample] = getHSVHist()
    imagepath = strcat(cd(cd('..')),'/train');
    maskpath = strcat(cd(cd('..')),'/mask');
    N = 15;
    
    I_hsv = cell(1,N);
    mask = cell(1,N);

    H_sample = [];
    S_sample = [];
    V_sample =  [];

    for k=1:N
        I_rgb =  imread(sprintf('%s/%03d.png',imagepath,k));
        I_hsv{k} = rgb2hsv(I_rgb);
        mask{k} = uint8(imread(sprintf('%s/%03d.png',maskpath,k)));
    end

    for k=1:N
        I = I_hsv{k};
        figure(1)
        subplot(2,3,[1,2,3]), imshow(I);
        title(strcat(num2str(k),' HSV histogram'))
        H = I(:,:,1);
        S = I(:,:,2);
        V = I(:,:,3);
        indx = mask{k}>0;
        H_sample = [H_sample;H(indx)];
        S_sample = [S_sample;S(indx)];
        V_sample = [V_sample;V(indx)];
        subplot(2,3,4),imhist(H(indx));
        subplot(2,3,5),imhist(S(indx));
        subplot(2,3,6),imhist(V(indx));
        pause(0.5);
    end
    
    figure(1),subplot(1,3,1),bar(histc(H_sample,[0:0.1:1])),subplot(1,3,2),bar(histc(S_sample,[0:0.1:1])),subplot(1,3,3),bar(histc(V_sample,[0:0.1:1]));
end
