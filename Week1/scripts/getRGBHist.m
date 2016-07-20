function [R_sample,G_sample,B_sample] = getRGBHist()
    imagepath = strcat(cd(cd('..')),'/train');
    maskpath = strcat(cd(cd('..')),'/mask');
    N = 15;

    I_rgb = cell(N,1);
    mask = cell(N,1);
    R_sample = [];
    G_sample = [];
    B_sample = [];
    for k=1:N
        I_rgb{k}=  imread(sprintf('%s/%03d.png',imagepath,k));
        mask{k} = uint8(imread(sprintf('%s/%03d.png',maskpath,k)));
    end

    for k=1:N
        I = I_rgb{k};
        figure(1)
        subplot(2,3,[1,2,3]), imshow(I);
        title(strcat(num2str(k),' RGB histogram'))
        R = I(:,:,1);
        G = I(:,:,2);
        B = I(:,:,3);
        indx = mask{k}>0;
        R_sample = [R_sample;R(indx)];
        G_sample = [G_sample;G(indx)];
        B_sample = [B_sample;B(indx)];   
        subplot(2,3,4),imhist(R(indx));
        subplot(2,3,5),imhist(G(indx));
        subplot(2,3,6),imhist(B(indx));
        pause(0.5);
    end

    close all;
    figure(1),subplot(1,3,1),bar(histc(R_sample,[0:255])),subplot(1,3,2),bar(histc(G_sample,[0:255])),subplot(1,3,3),bar(histc(B,[0:255]));
end