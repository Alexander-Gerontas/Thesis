function[dct_quant_img] = quantization(dct_img, quantTable, blocks)
        
    dct_quant_img = zeros(size(dct_img));    
    b = blocks - 1;

    for i = 1:blocks:size(dct_img,1)
        for j = 1:blocks:size(dct_img,2)

            % apothikeusi enos block se enan prosorino pinaka
            tmp = zeros(blocks, blocks);
            tmp(1:blocks, 1:blocks) = dct_img(i:i+b, j:j+b);
            
            % efarmogi kbantismou sto block
            quantBlock = (tmp ./ quantTable);
            
            % stroggilopoiisi ton timon tou block ston kontinotero akeraio
            dct_quant_img(i:i+b, j:j+b) = round(quantBlock);
        end
    end
end