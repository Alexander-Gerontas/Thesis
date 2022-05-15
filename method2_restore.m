addpath('./common/');
rmpath('./method1/');
addpath('./method2/');
addpath('./test_images/');
addpath('./libjpeg/');

clear;
close all;
clc;

% dilosi parametron 
L1 = 24; L2 = 6; block = 8;

% eisagogi tou kleidiou me to opoio egine i entesi se auti ti metabliti
key = 80;

% anoigma tis eikonas me to idatographima
jobj_stego = jpeg_read('results\stego_img.jpg');

% apothikeusi ton dct sinteleston tis eikonas
stego_quantImg = jobj_stego.coef_arrays{1,1};

% o kbantismos kai o antistrofos kbantismos tha ginoun me ton pinaka kbantismou tis eikonas
qf_table = jobj_stego.quant_tables{1,1};

% afairesi idatographimatos kai epanafora tis arxikis eikonas
[restored_quantImg, hidden_message] = dataExtraction(stego_quantImg, block, L1, L2, key);

% apothikeusi tis eikonas meta tin afairesi tou idatographimatos
jobj = jobj_stego;
jobj.optimize_coding = 1;
jobj.comments(1,1) = {[]};
jobj.coef_arrays{1,1} = restored_quantImg;
jpeg_write(jobj, 'results\restored_img.jpg');

fprintf("original image saved in folder 'results' and message is saved in workspace variable 'hidden_message' \n");