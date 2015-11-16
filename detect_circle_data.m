clc;
clear;
% This program can detect the circle with the image is a concentric circle

% set the file_path of the image
load white_cut_center.mat;

% cut out the image to the square, change rgb to gray, and change the
% value from integer to double
A_original = double(rgb2gray(white_cut_center));
% show the original image
figure;     colormap(gray);     image(A_original);
% hightlight the image from white=0 to white=1
% change range from 255 to 0
A = abs((A_original / 255.0)-1.0);
% set the square matrix with value zero

C_total = zeros(4001, 4001);

% for loop from 1 to 2
for i=1:40
    % use function imrotate to rotate the matrix
    B(:,:,i)=imrotate(A, 71* i,'crop');
    % multiplication of A and B
    C = A.*B(:,:,i);
    % accomulate C_total
    C_total = (C_total + C);
end

% hightlight the image from white=1 to white=0
% and change range from 0 to 255
C_final = (abs ( ( C_total / 5 ) - 1.0 ) * 255);
figure;     colormap(gray);     image(C_final);