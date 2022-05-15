addpath('./common/');
rmpath('./method1/');
addpath('./method2/');
addpath('./test_images/');
addpath('./libjpeg/');

clear;
close all;
clc;

block = 8;

% dilosi parametron kai mikous tixaiou minimatos
L1 = 24; L2 = 6; len = 0.5 * 10^4;

% anoigma tis arxikis eikonas
jobj = jpeg_read('.\test_images\lena70.jpg');
quantImg = jobj.coef_arrays{1,1}; 

% dimiourgia tixaiou minimatos
m1 = randi(2,1, len) - 1;

% mono me auto to kleidi mporei na anaktithei to minima apo tin eikona
key = 80;

% o kbantismos kai o antistrofos kbantismos tha ginoun me ton pinaka kbantismou tis eikonas
qf_table = jobj.quant_tables{1,1};

% apothikeusi eikonas xoris to idatoraphima se arxeio jpeg
jobj.optimize_coding = 1;
jpeg_write(jobj, '.\results\original_img.jpg');

% antistrofos kbantismos kai antistrofos dct - eikona xoris idatographima
dequantImg = jpegDequantization(quantImg, qf_table, block);

% eisagogi idatographimatos 
stego_quantImg = dataEmbedding(quantImg, block, L1, L2, key, m1); 

% enimerosi ton dct sinteleston tou jpeg object meta tin enthesi tou minimatos
jobj.coef_arrays{1,1} = stego_quantImg;

% apothikeusi tis eikonas me to idatographima
jobj.optimize_coding = 1;
jpeg_write(jobj, 'results\stego_img.jpg');

% anoigma tis eikonas me to idatographima
jobj_stego = jpeg_read('results\stego_img.jpg');

% apothikeusi ton dct sinteleston tis eikonas meta tin enthesi
stego_quantImg = jobj_stego.coef_arrays{1,1};

% antistrophos kbantismos, antistrophos dct - eikona me idatographima
stego_dequantImg = jpegDequantization(stego_quantImg, qf_table, block);

% eksagogi tou idatographimatos, tou minimatos kai epanafora tis eikonas
[restored_quantImg, m2] = dataExtraction(stego_quantImg, block, L1, L2, key);

% antistrophos kbantismos, antistrophos dct - eikona meta tin afairesi idatographimatos
restored_dequantImg = jpegDequantization(restored_quantImg, qf_table, block);

% euresi tou psnr metaksi tis eikonas prin tin enthesi kai tis eikonas meta tin enthesi
psnr_quant = psnr(uint8(stego_dequantImg), uint8(dequantImg));
fprintf("psnr: %f\n", psnr_quant);

% elegxoume an to arxiko minima einai to idio me auto pou kaname eksagogi apo tin eikona
msg_equal = isequal(m1, m2);
fprintf("message embedded and message extracted are the same: %s \n", string(msg_equal));

% elegxoume an h eikona meta tin eksagogi tou idatographimatos einai idia me tin arxiki
img_equal = isequal(restored_dequantImg, dequantImg);
fprintf("original image and restored image are the same: %s \n\n", string(img_equal));


