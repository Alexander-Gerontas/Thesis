function[signed_block, bits_embedded] = signDataEmbedding(jpeg_coef_block, m)
        
    % thesi tou pinaka m
    cnt = 1;
    
    % metritis ton bit pou exoyn eisaxthei
    bits_embedded = 0;
       
    % metatropi tou block se dianisma
    signed_block = reshapeArray(jpeg_coef_block);
    
    % epanalipsi gia olous tous ac orous
    for i = 2:length(signed_block(:))
        
        % entesi bit minimatos se orous me metro iso me ena
        if abs(signed_block(i)) == 1 && cnt <= length(m)
            b = m(cnt);
            signed_block(i) = signed_block(i) + signCoef(signed_block(i)) * b;
            cnt = cnt + 1;
            bits_embedded = bits_embedded + 1;

        % gia orous me metro megalitero apo ena ginetai auksisi tou metrou tous
        elseif abs(signed_block(i)) > 1
            signed_block(i) = signed_block(i) + signCoef(signed_block(i));                     
        end
    end

    % metatropi tou dianismatos se block 8x8
    signed_block = reshapeArray(signed_block, size(jpeg_coef_block, 1), size(jpeg_coef_block, 2));    
end