function[restored_img, m] = dataExtraction(stego_img, blocks, L1, L2, key)
      
    b = blocks - 1;
                            
    m = zeros(1, L1 + L2 + 50);
             
    total_extracted = 0;
                  
    restored_img = stego_img;
        
    % briskoume tin thesi tou dc coeficient kathe block
    block_start = getBlockIndex(stego_img, blocks);
           
    % orizoume tin sinthiki oste prota na ginei eksagogi tou L
    cond = L1; i = 0;
        
    % euresi ton block pou periexoun bit minimatos
    bitBlocks = selectExtractingBlocks(stego_img, blocks, L1 + L2);        
   
    % stin eksagogi ginontai treis epanalipseis opou se kathe epanalipsi eksagontai to L, to T kai telos to minima
    for j = 1:3
    
        while total_extracted < cond

            i = i + 1;
            
            % briskoume ton arithmo tou block apo tin 1i stili tou pinaka
            block_num = bitBlocks(i, 1);
            
            % briskoume tis sintetagmenes tou dc coef tou block
            x = block_start(block_num, 1);
            y = block_start(block_num, 2);        

            % apothikeusi tou block sti metabliti shuffled stego block
            stego_block = zeros(blocks, blocks);
            stego_block(1:blocks, 1:blocks) = stego_img(x:x+b, y:y+b);

            % blepoume posa bit exoun eisaxthei sto block
            tmp = sum(abs(stego_block(2:end)) == 1);     
            bits_embedded = tmp + sum(abs(stego_block(2:end)) == 2);
            
            % eksagogi ton bit apo to block
            [restored_block, msg_in_block] = signDataExtraction(stego_block, bits_embedded);

            % apothikeusi ton bit sto dianisma m
            m(total_extracted+1 : total_extracted + bits_embedded) = msg_in_block;

            total_extracted = total_extracted + bits_embedded;   

            % apothikeusi tou block meta tin ekagogi ton bit stin eikona            
            restored_img(x:x+b, y:y+b) = restored_block;        
        end
        
        % meta tin eksagogi tou L enimeronoume tin sinthiki epanalipsis
        if j == 1
                                    
            % metatropi tou L sto diadiko
            L_bin = num2str(m(1:L1));    
            L = bin2dec(L_bin);
        
            % enimerosi sinthikis oste na ginei eksagogi tou T
            cond = L1 + L2;
           
        % meta tin eksagogi tou T enimeronoume tin sinthiki epanalipsis
        elseif j == 2
            
            % metatropi tou T sto diadiko
            T_bin = num2str(m(L1+1:L1+L2));    
            T = bin2dec(T_bin);
                        
            tmp = zeros(1, L + L1 + L2);                        
            tmp(1:total_extracted) = m(1:total_extracted);                        
            m = tmp;
            
            % enimerosi sinthikis oste na ginei eksagogi tou minimatos
            cond = L + L1 + L2;
            
            % diagraphi ton block pou exei ginei i eksagogi tou L kai tou T
            bitBlocks(1:i, :) = [];
            
            % diagraphi ton block me arithmo midenikon < T
            bitBlocks(bitBlocks(:, 2) < T, :) = [];
            
            % i prospelasi tou pinaka bitBlocks ginetai apo tin arxi
            i = 0; 
            
            % dimiourgia pinaka me sintetagmenes anakatemenon ac sinteleston
            shuffled_ac_coord = getShuffledAcCoord(restored_img, blocks, bitBlocks(:,1), key);

            % anakatema ton mi midenikon ac oron stin  eikona me basi ton pinaka shuffled ac coord
            restored_img = swapElements(restored_img, shuffled_ac_coord);  
            stego_img = restored_img;          
        end        
    end
                           
    % enimerosi tou pinaka shuffled ac coord me tis nees times tis eikonas
    restored_ac_coord = updatedAcCoord(restored_img, shuffled_ac_coord);
        
    % epanafora ton mi midenikon ac oron stin arxiki tous thesi
    tmp = swapElements(restored_img, restored_ac_coord);
    restored_img = tmp;
            
    % apokopi ton L1, L2 pou den einai meros tou minimatos
    tmp = m(L1+L2+1 : L+L1+L2);
    m = tmp;
end