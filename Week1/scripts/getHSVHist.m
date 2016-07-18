function [H_hist,S_hist,V_hist] = getHSVHist()
    imagepath = strcat(cd(cd('..')),'/train');
    maskpath = strcat(cd(cd('..')),'/mask');
    N = 15;
    
    I_hsv = cell(1,N);
    mask = cell(1,N);

    H_hist = cell(1,N);
    S_hist = cell(1,N);
    V_hist = cell(1,N);

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
        H_hist{k} = imhist(H(mask{k}>0));
        S_hist{k} = imhist(S(mask{k}>0));
        V_hist{k} = imhist(V(mask{k}>0));    
        subplot(2,3,4),imhist(H(mask{k}>0));
        subplot(2,3,5),imhist(S(mask{k}>0));
        subplot(2,3,6),imhist(V(mask{k}>0));
        pause(0.5);
    end
end