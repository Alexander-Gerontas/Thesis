function[dc_pos_array] = getBlockIndex(dct_image, block)

    block_counter = 1;

    i = 1; j = -7;

    block_num = length(dct_image(:)) / block^2;
    
    % dimiourgia enos pinaka gia tin apothikeusi tis thesis tou DC orou gia kathe DCT
    % block tis eikonas
    dc_pos_array = zeros(block_num, 2);
    
    while block_counter < block_num + 1
                
        % euresi tis thesis i, j tou DC orou enos DCT block
        if j + block < size(dct_image, 2)
            j = j + block;            
        elseif j + block >= size(dct_image, 2) && i+ block <= size(dct_image, 1)
            j = 1;
            i = i + block;
        else
            break;            
        end
                
        % apothikeusi tou i, j ston pinaka me tis theseis
        dc_pos_array(block_counter, 1) = i;
        dc_pos_array(block_counter, 2) = j;
        
        block_counter = block_counter + 1;        
    end
end