function[restored_block, m] = signDataExtraction(signed_block, bits_embedded)

    m = zeros(1, bits_embedded);
    
    % thesi tou pinaka m
    cnt = 1;
    
    % metritis ton bit pou exoun eksaxthei
    bits_extracted = 0;
    
    % metatropi tou block se dianisma
    restored_block = reshapeArray(signed_block);
            
    for i = 2:length(restored_block(:))       

        % otan brethoun ac oroi me times 1, 2 ginetai eksagogi bit apo autous
        if (abs(restored_block(i)) == 1 || abs(restored_block(i)) == 2) && bits_extracted < bits_embedded

            bit = abs(restored_block(i)) - 1;

            m(cnt) = bit;
            cnt = cnt + 1;
            bits_extracted = bits_extracted + 1;                

            restored_block(i) = signCoef(restored_block(i));           
            
        % gia tous ipolipous orous ginetai epanafora tis arxikis tous timis
        else
            restored_block(i) = restored_block(i) - signCoef(restored_block(i));
        end        
    end
    
    % epanafora tou block se pinaka 8x8    
    restored_block = reshapeArray(restored_block, size(signed_block, 1), size(signed_block, 2));
end