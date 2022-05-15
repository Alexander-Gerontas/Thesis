function[dct_img] = iquantization(dct_quant_img, quantTable, blocks)
       
    % dimiourgia enos pinaka gia tin apothikeusi tis neas eikonas 
    dct_img = zeros(size(dct_quant_img));    
    b = blocks - 1;
 
    for i = 1:blocks:size(dct_quant_img,1)
        for j = 1:blocks:size(dct_quant_img,2)

            % apothikeusi enos block se enan prosorino pinaka
            tmp = zeros(blocks, blocks);
            tmp(1:blocks, 1:blocks) = dct_quant_img(i:i+b, j:j+b);

            % efarmogi antistrofou kbantismou sto block
            quantBlock = tmp .* quantTable;
            
            % apothikeusi tou block meta ton antistrofo kbantismo stin nea eikona
            dct_img(i:i+b, j:j+b) = quantBlock;
        end
    end
end