rmpath('./method2/');
addpath('./common/');
addpath('./libjpeg/');
addpath('./method1/');

clear;
close all;
clc;

block = 8;

% anoigma tis eikonas me to idatographima
jobj_stego = jpeg_read('results\stego_img.jpg');

% apothikeusi ton dct sinteleston tis eikonas
stego_quantImg = jobj_stego.coef_arrays{1,1};

% euresi tou S, T kai tou mikous tou minimatos apo to header tis stego eikonas
param = jobj_stego.comments(1,1);
param = cell2mat(param);
param = str2num(param);

S = param(1);
T = param(2);
len = param(3);
o1 = param(4);
o2 = param(5);

% o kbantismos kai o antistrofos kbantismos tha ginoun me ton pinaka kbantismou tis eikonas
qf_table = jobj_stego.quant_tables{1,1};

% afairesi idatographimatos kai epanafora tis arxikis eikonas
[restored_quantImg, hidden_message] = dataExtraction(stego_quantImg, block, o1, o2, S, T, len);

% apothikeusi tis eikonas meta tin afairesi tou idatographimatos
jobj = jobj_stego;
jobj.optimize_coding = 1;
jobj.comments(1,1) = {[]};
jobj.coef_arrays{1,1} = restored_quantImg;
jpeg_write(jobj, 'results\restored_img.jpg');

fprintf("original image saved in folder 'results' and message is saved in workspace variable 'hidden_message' \n");