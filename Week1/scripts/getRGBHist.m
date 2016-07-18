function [R_hist,G_hist,B_hist] = getRGBHist()
    imagepath = strcat(cd(cd('..')),'/train');
    maskpath = strcat(cd(cd('..')),'/mask');
    N = 15;

    I_rgb = cell(1,N);
    mask = cell(1,N);

    R_hist = cell(1,N);
    G_hist = cell(1,N);

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
        R_hist{k} = imhist(R(mask{k}>0));
        G_hist{k} = imhist(G(mask{k}>0));
        B_hist{k} = imhist(B(mask{k}>0));    
        subplot(2,3,4),imhist(R(mask{k}>0));
        subplot(2,3,5),imhist(G(mask{k}>0));
        subplot(2,3,6),imhist(B(mask{k}>0));
        pause(0.5);
    end
end