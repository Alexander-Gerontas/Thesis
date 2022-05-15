function[restored_img, m] = dataExtraction(stego_img, blocks, o1, o2, S, T, total_bits)
      
    b = blocks - 1;
    
    restored_img = stego_img;
    
    m = zeros(1, total_bits);
             
    total_extracted = 0;
                  
    % briskoume tin thesi tou dc sintelesti kathe block
    block_start = getBlockIndex(stego_img, blocks);
    
    total_blocks = length(stego_img(:)) / (blocks^2);
  
    % epanalipsi gia kathe block tis eikonas
    for i = 1:total_blocks
               
        % briskoume tis sintetagmenes tou dc sintelesti tou block
        x = block_start(i, 1);
        y = block_start(i, 2);
                              
        % apothikeusi tou block se enan pinaka
        stego_img_block = zeros(blocks, blocks);
        stego_img_block(1:blocks, 1:blocks) = stego_img(x:x+b, y:y+b);
                                    
        % eksagogi ton bit kai epanafora autou tou block
        [restored_block, msg_in_block] = histPairDataExtraction(stego_img_block, S, T, o1, o2);
        
        bits_embedded = length(msg_in_block(:));
        
        % apothikeusi ton bit pou eksagame ston pinaka m
        m(total_extracted+1 : total_extracted + bits_embedded) = msg_in_block;

        total_extracted = total_extracted + bits_embedded;   

        % apothikeusi tou block meta tin epanafora stin eikona
        restored_img(x:x+b, y:y+b) = restored_block;
                
        % otan ginei ekagogi olon ton bit termatizoume to brogxo
        if total_extracted >= total_bits, break; end        
    end
                
    % apokopi ton bit pou den einai meros tou minimatos
    m = m(1:total_bits);
end