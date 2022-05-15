function[restored_img] = jpegDequantization(DCT_image, quantTable, block)
   
    % antistrofos kbantismos kai antistrofos dct stin eikona
    iquantDct = iquantization(DCT_image, quantTable, block);
    restored_img = idctBlocks(iquantDct, block);
    
    % strogilopoiisi ton timon entasis tis eikonas ston kontinotero akaireo
    restored_img = uint8(restored_img);
end