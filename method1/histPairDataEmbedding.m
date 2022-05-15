function[hs_block, bits_embedded] = histPairDataEmbedding(jpeg_coef_block, m, bits_tobe_embedded, S, T, o1, o2)

    P = T;
    
    cnt = 1;
    
    % metritis ton bit pou exoyn eisaxthei
    bits_embedded = 0;
             
    % metatropi tou block se dianisma se diataksi zigzag
    hs_block = zigzag(jpeg_coef_block);
         
    % i metatopisi istogramatos kai i enthesi afora mono tin perioxi o1, o2 sto block
    block_part = hs_block(o1 : o2);
                 
    while (1)
                
        % metatopisi tou istogrammatos aristera i deksia analoga me tin timi tou P
        for i = 1:length(block_part(:))
            
            if block_part(i) > P && P >= 0 
                block_part(i) = block_part(i) + 1;

            elseif block_part(i) < P && P < 0 
                block_part(i) = block_part(i) - 1;                          
            end            
        end
        
        % diasxisi tis perioxis o1, o2 kai enthesi bit stous sintelests me timi isi me P
        for i = 1:length(block_part(:))           

            if bits_embedded == bits_tobe_embedded, break; end

            b = m(cnt);

            if P >= 0 && block_part(i) == P       

                block_part(i) = block_part(i) + b;

                cnt = cnt + 1;
                bits_embedded = bits_embedded + 1;

            elseif P < 0 && block_part(i) == P

                block_part(i) = block_part(i) - b;

                cnt = cnt + 1;
                bits_embedded = bits_embedded + 1;
            end                
        end
        
        % termatismos tou brogxou otan to P ginei iso me S                                   
        if P == S, break; end
        
        % allagi tis timis tou P
        if P > 0 
            P = -P;
        elseif P < 0
            P = -P - 1;                
        end      
    end
         
    % afou exoume metabalei tis times stin perioxi o1, o2 tis apothikeoume sto block
    hs_block(o1:o2) = block_part(:);
    
    % antistofi tis zigzag diataksis sto block
    hs_block = izigzag(hs_block);       
end