function[stego_img] = dataEmbedding(dct_image, blocks, L1, L2, key, m)
      
    b = blocks - 1;
    
    % epilogi ton block sta opoia tha ginei i enthesi tou minimatos kai ebresi tou katalilou T    
    [bitBlocks, T] = selectEmbeddingBlocks(dct_image, blocks, L1 + L2, length(m));
        
    % arxikopoiisi tis stego eikonas
    shuffled_stego_img = dct_image;

    % L : mikos tou minimatos
    L = length(m);
    
    % arxikopoisi enos dianismatos pou tha apothikeutei to L to T kai to minima sto diadiko
    msg_L_T = zeros(1, L + L1 + L2);
    
    % metatropi tou L sto diadiko
    L_bin = decimal2binary(L);
    L_bin = str2vector(L_bin);
            
    % topothetisi tou L_bin sto telos enos dianismatos me midenika megethous L1 
    tmp = zeros(1,L1);
    tmp(L1+1-length(L_bin):L1) = L_bin(:);    
    L_bin = tmp;
    
    % apothikeusi tou L_bin stin arxi tou dianismatos m_remain
    msg_L_T(1:L1) = L_bin(:);
    
    % metatropi tou T sto diadiko
    T_bin = decimal2binary(T);
    T_bin = str2vector(T_bin);
    
    % topothetisi tou T_bin sto telos enos dianismatos me midenika megethous L2
    tmp = zeros(1,L2);        
    tmp(L2+1-length(T_bin):L2) = T_bin(:);
    T_bin = tmp;
                    
    % apothikeusi tou T_bin sto dianisma m_remain meta to L_bin        
    msg_L_T(L1 + 1 : L1 + L2) = T_bin(:);
    
    % eisagogi ton bit tou minimatos meta ta L_bin, T_bin
    msg_L_T(L1+L2+1 : L1+L2+L) = m(:);
        
    % prosthiki midenikon sto telos tou minimatos gia tin periptosi opou ta bit pou mporoun na eisaxthoun sta block ksepernoun to minima
    tmp = zeros(1, length(msg_L_T) + blocks^2);
    tmp(1:length(msg_L_T)) = msg_L_T(:);
    msg_L_T = tmp;
               
    % briskoume tin thesi tou dc coeficient kathe block
    block_start = getBlockIndex(dct_image, blocks);
        
    total_bits_embedded = 0;
    
    % orizoume tin sinthiki oste prota na ginei eisagogi tou L kai tou T
    cond = L1 + L2;
    
    i = 0;
     
    % stin eisagogi ginontai dio epanalipseis opou stin 1h epanalipsi eisagontai to L kai to T kai sti deuteri to minima
    for j = 1:2
        while total_bits_embedded < cond        

            i = i + 1;
                        
            % briskoume ton arithmo tou block apo tin 1i stili tou pinaka
            block_num = bitBlocks(i, 1);

            % briskoume tis sintetagmenes tou dc coef tou block
            x = block_start(block_num, 1);
            y = block_start(block_num, 2);

            % apothikeusi tou block sti metabliti jpeg block
            jpeg_block = zeros(blocks, blocks);            
            jpeg_block(1:blocks, 1:blocks) = dct_image(x:x+b, y:y+b);
            
            % ypologismos ton bit pou mporoun na eisaxthoun sto block     
            bits_tobe_embedded = sum(abs(jpeg_block(2:end)) == 1);
                                    
            % apothikeuoume ta bit pou tha eisaxthoun sto block se mia prosorini metabliti
            tmp_m = msg_L_T(1:bits_tobe_embedded);

            % eisagogi idatographimatos sto block
            [signed_block, bits_embedded] = signDataEmbedding(jpeg_block, tmp_m);

            % meta tin eisagogi diagraphoume ta bit pou exoun eisaxthei apo to dianisma me ta bit pou prokeitai na eisaxthoun
            msg_L_T = msg_L_T(bits_embedded+1:end);

            % apothikeuoume to block stin idatographimeni eikona           
            shuffled_stego_img(x:x+b, y:y+b) = signed_block;

            total_bits_embedded = total_bits_embedded + bits_embedded;
        end  
        
        % anakatema ton ac oron meta tin enthesi tou L kai tou T
        if j == 1
                        
            % enimerosi sinthikis epanalalipsis
            cond = L + L1 + L2;
                        
            % dimiourgia pinaka me sintetagmenes anakatemenon ac sinteleston
            shuffled_ac_coord = getShuffledAcCoord(shuffled_stego_img, blocks, bitBlocks(i+1:end,1), key);

            % anakatema ton mi midenikon ac oron stin kbantismaeni eikona me basi ton pinaka shuffled ac coord
            dct_image = swapElements(shuffled_stego_img, shuffled_ac_coord);   
            shuffled_stego_img = dct_image;
        end    
    end
        
    % enimerosi tou pinaka shuffled array me tis nees times tis idatographimenis eikonas
    stego_ac_coord = updatedAcCoord(shuffled_stego_img, shuffled_ac_coord);
    
    % epanafora ton ipogegramenon ac oron stin arxiki tous thesi
    tmp = swapElements(shuffled_stego_img, stego_ac_coord);
    stego_img = tmp;
end