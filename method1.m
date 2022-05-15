rmpath('./method2/');
addpath('./common/');
addpath('./libjpeg/');
addpath('./method1/');

clear;
close all;
clc;

% anoigma tis arxikis eikonas
jobj = jpeg_read('.\test_images\lena70.jpg');

% apothikeusi ton dct sinteleston tis eikonas
quantImg = jobj.coef_arrays{1,1};

% mikos tou tixaiou minimatos 
len = 1000; 

% h perioxi o1, o2 stin opoia tha ginei enthesi se kathe block tis eikonas
o1 = 4; o2 = 36;

% dimiourgia tixaiou minimatos
m1 = randi(2,1, len) - 1;
block = 8;

% o kbantismos kai o antistrofos kbantismos tha ginoun me ton pinaka kbantismou tis eikonas
qf_table = jobj.quant_tables{1,1};

% antistrofos kbantismos kai antistrofos dct - eikona xoris idatographima
dequantImg = jpegDequantization(quantImg, qf_table, block);

% apothikeusi tis eikonas xoris to idatographima
jobj.optimize_coding = 1;
jpeg_write(jobj, 'results\original_img.jpg');

% eisagogi idatographimatos me tin methodo tou xuan
[stego_quantImg, S, T] = dataEmbedding(quantImg, block, o1, o2, m1);

% enimerosi ton dct sinteleston tou jpeg object meta tin enthesi tou minimatos
jobj.coef_arrays{1,1} = stego_quantImg;

% eisagogi ton parametron S, T, o1, o2 kai tou mikos tou minimatos san sxolio stin eikona 
jobj.comments(1,1) = {[num2str(S) ' ' num2str(T) ' ' num2str(len) ' ' num2str(o1) ' ' num2str(o2)]};

% apothikeusi tis eikonas me to idatographima
jobj.optimize_coding = 1;
jpeg_write(jobj, 'results\stego_img.jpg');

% anoigma tis eikonas me to idatographima
jobj_stego = jpeg_read('results\stego_img.jpg');
stego_quantImg = jobj_stego.coef_arrays{1,1};

% euresi tou S, T, tou eurous o1, o2 kai tou mikous tou minimatos apo to header tis eikonas
param = jobj_stego.comments(1,1);
param = cell2mat(param);
param = str2num(param);

S = param(1);
T = param(2);
len = param(3);
o1 = param(4);
o2 = param(5);

% antistrophos kbantismos, antistrophos dct - eikona me idatographima
stego_dequantImg = jpegDequantization(stego_quantImg, qf_table, block);

% eksagogi tou idatographimatos, tou minimatos kai epanafora tis eikonas
[restored_quantImg, m2] = dataExtraction(stego_quantImg, block, o1, o2, S, T, len);

% euresi tou psnr metaksi tis eikonas prin tin enthesi kai tis eikonas meta tin enthesi
psnr_quant = psnr(uint8(stego_dequantImg), uint8(dequantImg));
fprintf("psnr: %f\n", psnr_quant);

% elegxoume an to arxiko minima einai to idio me auto pou kaname eksagogi apo tin eikona
msg_equal = isequal(m1, m2);
fprintf("message embedded and message extracted are the same: %s \n", string(msg_equal));

% antistrophos kbantismos stin eikona meta tin afairesi tou idatographimatos
restored_dequantImg = jpegDequantization(restored_quantImg, qf_table, block);

% elegxoume an h eikona meta tin eksagogi tou idatographimatos einai idia me tin arxiki
img_equal = isequal(restored_dequantImg, dequantImg);
fprintf("original image and restored image are the same: %s \n\n", string(img_equal));
