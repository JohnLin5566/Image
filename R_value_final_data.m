% This program can use the CRSP method to find the center of the circle

clc
clear
close all
% time start
tic
% set the file_path of the image
load oil_cut.mat;
% change rgb to gray, and change the value from integer to double
A_original = double(rgb2gray(oil_cut));
A_edge = edge(A_original,'sobel');
% show the original image
figure;     colormap(gray);     image(A_original);
% hightlight the image from white=0 to white=1
% change range from 255 to 0
A = abs((A_edge / 255.0)-1.0);
% find the size of the picture
[width,length]=size(A);   
% loop start, for(i=1; i=width; 20++)
for i=1:87:width
    for j=1:87:length
        % create a  0 matrix about 4 times bigger than original picture 
        A_edge_move=zeros(2*width-1,2*length-1); 
        % let 0 matrix covered by original picture and let every pixels of
        % the original picture be the rotated center
        A_edge_move(width+1-i:2*width-i,length+1-j:2*length-j)=A;
        % let C_total be same size with 0 matrix 
        C_total = zeros(2*width-1,2*length-1);

            B(:,:,1)=imrotate(A_edge_move, 119* 1,'crop');
            B(:,:,2)=imrotate(A_edge_move, 119* 2,'crop');
            B(:,:,3)=imrotate(A_edge_move, 119* 3,'crop');
            B_pi = B(:,:,1).*B(:, :, 2).*B(:, :, 3);
            C_total = (C_total + B_pi);

        
        % calculate the sum of C  (R is the z axis of pcolor)
        R(i,j)=sum(sum(C_total/3));
        end
end
% show the position of maximum
[R_x_max,R_y_max] = find(R==max(max(R)));
% time end
toc
time=toc;
% a is the x axis of pcolor, b is the y axis of pcolor
a=[];
for l=1:width
    q=1:length;
    a=[a;q];
end
b=[];
for m=1:length
    w=(1:width)';
    b=[b w];
end
% show the final RSCP result
figure;     pcolor(a,b,R);      colorbar