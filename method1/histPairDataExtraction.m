function[hs_block, m] = histPairDataExtraction(img_block, S, T, o1, o2)

    P = S;
        
    m = [];
          
    bits_extracted = 0;
    
    % metatropi tou block se dianisma se diataksi zigzag
    hs_block = zigzag(img_block);    
        
    % i eksagogi kai i epanafora afora mono tin perioxi o1, o2 sto block
    tmp_block = hs_block(o1 : o2);
              
    while (1)
                                                        
        % eksagogi bit apo to block kai epanafora tis arxikis tou timis
        for i = length(tmp_block(:)):-1:1
            
            bit_found = 0;
            
            if P >= 0 && (tmp_block(i) == P || tmp_block(i) == P+1)

                bit = tmp_block(i) - P;
                bit_found = 1;      
                
            elseif P < 0 && (tmp_block(i) == P || tmp_block(i) == P-1)
                    
                bit = P - tmp_block(i);
                bit_found = 1;
            end
            
            if bit_found == 1
                
                tmp_block(i) = P; 
                m = [m bit]; 
                bits_extracted = bits_extracted + 1;
            end            
        end
        
        % metatopisi tou istogrammatos aristera i deksia analoga me tin timi tou P
        for i = 1:length(tmp_block(:))  
                         
            if tmp_block(i) > P && P >= 0          
                tmp_block(i) = tmp_block(i) - 1;

            elseif tmp_block(i) < P && P < 0
                tmp_block(i) = tmp_block(i) + 1;                          
            end           
        end
                  
        % termatismos tou brogxou otan to P ginei iso me T
        if P == T, break; end 
        
        % allagi tis timis tou P
        if P > 0 
            P = -P - 1;
        elseif P < 0
            P = -P;
        elseif P == 0
            P = -1;
        end
               
    end
    
    % afou exoume epanaferei tis times stin perioxi o1, o2 tis apothikeoume sto block
    hs_block(o1:o2) = tmp_block(:);

    % antistofi tis zigzag diataksis sto block
    hs_block = izigzag(hs_block(:));
           
    % kathos ta bit tou minimatos anaktounte apo to teleutaio pros to proto
    % ginetai antistrophi tou pinaka me ta bit minimatos      
    m = flip(m);                     
end