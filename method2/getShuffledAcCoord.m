function[shuffled_ac_coord] = getShuffledAcCoord(dct_image, blocks, block_index, key)
       
    b = blocks - 1;
    
    total_blocks = length(block_index(:));
        
    % briskoume tin thesi tou dc coeficient kathe block
    block_start = getBlockIndex(dct_image, blocks);
            
    % dimourgia pinaka gia tin apothikeusi ton ac oron kai ton sintetagmenon tous
    ac_coord = zeros(total_blocks * 63, 4);
    
    array_index = 0;
        
    % euresi ton sintetagmenon ton mi midenikon ac oron
    for i = 1:total_blocks
               
        block_num = block_index(i);
        
        x = block_start(block_num, 1);
        y = block_start(block_num, 2);
        
        % apothikeusi enos block ston pinaka quant_block
        quant_block = zeros(blocks, blocks);
        quant_block(1:blocks, 1:blocks) = dct_image(x:x+b, y:y+b);
          
        x = x - 1; y = y - 1;
        
        % midenismos dc orou
        quant_block(1, 1) = 0;
        
        % metatropi olon ton ac oron tou block se thetikous
        tmp = abs(quant_block);
        quant_block = tmp;
                
        % apothikeusi ton sintetagmenon ton mi midenikon ac oron stis metablites var1, var2
        [var1, var2] = find(quant_block > 0);
        
        % len: arithmos mi midenikon coef sto block
        len = length(var1(:));
        
        % apothikeusi tou index tou ac orou (1), ton sintetagmenon tou (2,3) kai tis timis tou ac orou (4)
        ac_coord(array_index+1 : array_index+len, 1) = array_index + (1:len);
        ac_coord(array_index+1 : array_index+len, 2) = x + var1(:);
        ac_coord(array_index+1 : array_index+len, 3) = y + var2(:);

        for j = 1:len
            ac_coord(array_index + j, 4) = dct_image(x + var1(j), y + var2(j));
        end
        
        array_index = array_index + len;        
    end
        
    % diagraphi midenikon kelion apo ton pinaka
    tmp = ac_coord(1:array_index, :);    
    ac_coord = tmp;
            
    % dinoume gia seed stin gennitria tuxaion arithmon to kleidi mas
    rng(key);
            
    % anakatema tou arithmou tou block kai ton timon ton ac oron kata grammi    
    shuffled_ac_coord = ac_coord;
    tmp = shuffled_ac_coord(randperm(size(shuffled_ac_coord, 1)), :);
    shuffled_ac_coord = tmp;
    
    % oi sintetagmenes menoun idies
    shuffled_ac_coord(:,2) = ac_coord(1:end, 2);
    shuffled_ac_coord(:,3) = ac_coord(1:end, 3);
end