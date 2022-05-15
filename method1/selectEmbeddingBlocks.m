function[dataBlock, S, T] = selectEmbeddingBlocks(quantDct, blocks, o1, o2, m)
       
    b = blocks - 1;
    
    total_blocks = length(quantDct(:)) / (blocks^2);
    
    dataBlock = zeros(total_blocks, 3);
   
    tmp_quantDct = zeros(total_blocks, o2 - o1 + 1);
    
    tmp_cnt = 1;
    
    % dimiourgia pinaka mono me tous ac sintelestes stin perioxi o1, o2    
    for i = 1:blocks:size(quantDct,1)
        for j = 1:blocks:size(quantDct,2)
        
            quant_block = zeros(blocks, blocks);
            quant_block(1:blocks, 1:blocks) = quantDct(i:i+b, j:j+b);
                        
            hs_block = zigzag(quant_block);         
            block_part = hs_block(o1 : o2);
                      
            tmp_quantDct(tmp_cnt,:) = block_part;
            
            tmp_cnt = tmp_cnt + 1;
        end
    end
        
    abs_tmp_quantDct = abs(tmp_quantDct(:));
    
    S = 0; T = 0;
      
    % apofeugoume na eisagoume to minima se midenikous ac sintelestes
    if sum(abs_tmp_quantDct(:) >= 1) >= length(m(:)), S = 1; T = 1; end
    
    % ypologismos ton timon S, T
    while T < max(abs_tmp_quantDct(:))
       
        tmp1 = 0; tmp2 = 0;
       
        % i timi tou T anebainei an mporoume na eisagoume to minima sto metro sigkekrimenou ac sintelesti
        tmp_bits1 = sum(abs_tmp_quantDct(:) >= S+1 & abs_tmp_quantDct(:) <= T+1);    
        
        % i an den eparkoun oi ac sintelestes gia tin enthesi me ta trexon S kai T
        tmp_bits2 = sum(abs_tmp_quantDct(:) >= S & abs_tmp_quantDct(:) <= T);
                
        if tmp_bits1 >= length(m(:)) || tmp_bits2 < length(m(:))
            T = T + 1;
            tmp1 = 1;
            
        else, break;
        end
           
        tmp_bits1 = sum(abs_tmp_quantDct(:) >= S + 1 & abs_tmp_quantDct(:) <= T);
                  
        % auksanoume tin timi tou S an mporoume na eisagoume to minima me megaliteri timi tou
        if T > S && tmp_bits1 >= length(m(:))
            S = S + 1;                        
            tmp2 = 1;            
        end
        
        % an den exei alaksei oute i timi tou S i tou T termatizoume ton bronxo        
        if tmp1 == 0 && tmp2 == 0, break; end        
    end
        
    % an oi thetikoi ac sintelestes dn eparkoun gia tin enthesi antistrefoume tin timi tou S gia na ginei enthesi kai stous arnitikous
    if sum(tmp_quantDct(:) >= S & tmp_quantDct(:) <= T) < length(m(:))
        S = -S;
    end
          
    neg_S = -abs(S);
    if S >= 0, neg_S = -abs(S+1); end
                
    block_cnt = 1;
     
    % euresi tou arithmou ton bit pou mporoun na eisaxthoun se kathe block
    for i = 1:blocks:size(quantDct,1)
        for j = 1:blocks:size(quantDct,2)
        
            quant_block = zeros(blocks, blocks);
            quant_block(1:blocks, 1:blocks) = quantDct(i:i+b, j:j+b);
             
            hs_block = zigzag(quant_block);         
            block_part = hs_block(o1 : o2);
            
            bits1 = sum(block_part(:) >= abs(S) & block_part(:) <= T);
            bits2 = 0;
            
            if S < T            
                bits2 = sum(block_part(:) >= -T & block_part(:) <= neg_S);
            end
                     
            dataBlock(block_cnt, 1) = block_cnt;
            dataBlock(block_cnt, 3) = bits1 + bits2;
            
            block_cnt = block_cnt + 1;
        end
    end
    
    % se periptosi pou dn mporoume na eisagoume to minima stin eikona tiponoume minima apotixias
    if sum(dataBlock(:, 3)) < length(m(:))
        error("Cannot embed %d bits in image \nMax bits that can be embedded in image: %d \n", length(m(:)), sum(dataBlock(:, 3)));
    end
        
    i = 1;
    
    % epilogi block gia tin eisagogi bit. 
    while sum(dataBlock(1:i, 3)) < length(m(:))                  
        i = i + 1;
    end
  
    % diagraphi ton block sta opoia dn tha ginei eisagogi minimatos apo ton pinaka dataBlock
    dataBlock(i+1:end, :) = [];
end