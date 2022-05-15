function[bitBlocks] = selectExtractingBlocks(stego_quantDct, blocks, L1_L2)
       
    b = blocks - 1;
    
    total_blocks = length(stego_quantDct(:)) / (blocks^2);
    
    dataBlock = zeros(total_blocks, 3);
        
    % briskoume tin thesi tou dc coeficient kathe block
    block_start = getBlockIndex(stego_quantDct, blocks);
    
    for i = 1:size(dataBlock,1)
        
        % pairnoume ton arithmo tou block apo tin 1i stili tou pinaka
        block_num = i;
        
        % briskoume tis sintetagmenes tou dc coef tou block
        x = block_start(i, 1);
        y = block_start(i, 2);
        
        % apothikeusi tou block se enan pinaka
        quant_block = zeros(blocks, blocks);
        quant_block(1:blocks, 1:blocks) = stego_quantDct(x:x+b, y:y+b);
        
        dataBlock(block_num, 1) = block_num;
        dataBlock(block_num, 2) = sum(quant_block(2:end) == 0);
        
        tmp1 = sum(abs(quant_block(2:end)) == 1);        
        tmp2 = sum(abs(quant_block(2:end)) == 2);      
        
        % apothikeusi tou arithmou ton ac oron me metro ena h dio stin 3h stili tou pinaka
        dataBlock(i, 3) = tmp1 + tmp2;        
    end
    
    % an oloi oi ac sintelestes se ena block exoun mideniki timi diagraphoume auto to block   
    dataBlock(dataBlock(:, 2) == blocks^2 - 1, :) = [];
    
    z = 0; block_m_len = 0;
    bitBlocks = zeros(size(dataBlock));
        
    % epilogi ton block apo ta opoia tha eksaxthoun ta L1, L2
    for i = 1:size(dataBlock,1)     
        if block_m_len < L1_L2
            z = z + 1;
            bitBlocks(z, :) = dataBlock(i, :);
            block_m_len = block_m_len + dataBlock(i, 3);
            
        % otan exoume epileksei block tosa oste na mporei na ginei i eisagogi tou minimatos i epanalipsi stamataei
        elseif block_m_len >= L1_L2, break; end                      
    end
    
    % diagraphi ton block pou epilextikan gia tin eisagogi L1, L2 apo ton pinaka dataBlock   
    dataBlock(1:z, :) = [];  
    
    bitBlocks(z+1 : end, :) = dataBlock(1:end, :);
end