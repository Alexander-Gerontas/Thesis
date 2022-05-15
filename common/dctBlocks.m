function[dctImg] = dctBlocks(img, n)
    
    % dimiourgia pinaka gia tin apothikeusi tis DCT eikonas 
    dctImg = zeros(size(img));    
    se = n-1;

    for i = 1:n:size(img,1)               
        for j = 1:n:size(img,2)
            
            % apothikeusi enos block se enan prosorino pinaka
            img_block = zeros(n, n);
            img_block(1:n, 1:n) = img(i:i+se, j:j+se);
            
            % olisthisi kata -128 epipeda entasis sta pixel tou block
            tmp = img_block - 128; 
            
            % efarmogi tou metasximatismou dct sto block
            dct_block = dct2(tmp);        
                                    
            % apothikeusi tou block meta ton metasximatismo stin dct eikona
            dctImg(i:i+se, j:j+se) = dct_block;
        end        
    end
end