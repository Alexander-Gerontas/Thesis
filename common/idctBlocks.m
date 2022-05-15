function[newImg] = idctBlocks(dct_img, n)
    
    % dimiourgia pinaka gia tin apothikeusi tis dct eikonas 
    newImg = zeros(size(dct_img));
    se = n-1;

    for i = 1:n:size(dct_img,1)                
        for j = 1:n:size(dct_img,2)
            
            % apothikeusi enos DCT block se enan prosorino pinaka
            tmp_block = zeros(n, n);
            tmp_block(1:n, 1:n) = dct_img(i:i+se, j:j+se);
            
            % efarmogi tou antistrofou metasximatismou DCT sto block
            tmp = idct2(tmp_block);
                           
            % olisthisi kata 128 epipeda entasis sta pixel tou DCT block
            tmp = tmp + 128;
                       
            % apothikeusi tou block meta ton antistrofo metasximatismo stin eikona
            newImg(i:i+se, j:j+se) = tmp;
        end
    end
end