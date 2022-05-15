function[dct_quant_image] = jpegQuantization(img, quantTable, block)    

    % efarmogi metasximatismou DCT stin arxiki eikona
    dct_image = dctBlocks(img, block);
    
    % kbantismos tis DCT eikonas
    dct_quant_image = quantization(dct_image, quantTable, block);    
end