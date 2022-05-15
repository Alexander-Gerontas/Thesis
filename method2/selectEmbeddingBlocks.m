function[bitBlocks, T] = selectEmbeddingBlocks(quantDct, blocks, L1_L2, msg_len)
       
    b = blocks - 1;
    
    total_m_len = L1_L2 + msg_len;
    
    total_blocks = length(quantDct(:)) / (blocks^2);
    
    dataBlock = zeros(total_blocks, 3);
            
    block_cnt = 1;    
    
    % metrisi ton ac oron se kathe block me timi 0 kai metro 1
    for i = 1:blocks:size(quantDct,1)
        for j = 1:blocks:size(quantDct,2)
        
            quant_block = zeros(blocks, blocks);
            quant_block(1:blocks, 1:blocks) = quantDct(i:i+b, j:j+b);
            
            dataBlock(block_cnt, 1) = block_cnt;
            
            % apothikeusi tou arithmou ton ac oron me timi 0 stin 2h stili tou pinaka
            dataBlock(block_cnt, 2) = sum(quant_block(2:end) == 0);
            
            % apothikeusi tou arithmou ton ac oron me metro 1 stin 3h stili tou pinaka
            dataBlock(block_cnt, 3) = sum(abs(quant_block(2:end)) == 1);        
                                    
            block_cnt = block_cnt + 1;
        end
    end
        
    % an oloi oi ac sintelestes se ena block exoun mideniki timi diagraphoume auto to block    
    dataBlock(dataBlock(:, 2) == blocks^2 - 1, :) = [];
            
    z = 0; block_m_len = 0;
    bitBlocks = zeros(size(dataBlock));
    
    % epilogi ton block sta opoia tha eisaxthoun ta L1, L2 kai eisagogi tous ston pinaka bitBlocks    
    for i = 1:size(dataBlock,1)
        if block_m_len < L1_L2
            z = z + 1;
            bitBlocks(z,:) = dataBlock(i, :);
            block_m_len = block_m_len + dataBlock(i, 3);
                        
        % otan exoume epileksei block tosa oste na mporei na ginei i eisagogi tou minimatos i epanalipsi stamataei
        elseif block_m_len >= L1_L2, break; end                      
    end
    
    % diagraphi ton block pou epilextikan gia tin eisagogi L1, L2 apo ton pinaka dataBlock   
    dataBlock(1:z, :) = [];  
    
    T = 0;
    tmp = dataBlock;
        
    while T < 64
       
        % diagraphi ton block pou exoun arithmo midenikon < T + 1
        tmp(tmp(:, 2) < T + 1, :) = [];
       
        % an exoume arketous sintelestes me metro 1 etsi oste na ginei i enthesi auksanoume tin timi tou T kai sinexizoume tin epanalipsi        
        if sum(tmp(:, 3)) >= msg_len
            T = T + 1;
        
        % otan brethei to megisto T etsi oste na mporei na ginei i enthesi i epanalipsi stamataei        
        else, break;
        end        
    end
    
    % diagraphi ton block me arithmo midenikon < T
    dataBlock(dataBlock(:, 2) < T, :) = [];
           
    % eisagogi ton taksinomimenon block ston pinaka bitBlocks  
    bitBlocks(z+1 : z+size(dataBlock(:,1)), :) = dataBlock(1:end, :);
        
    % diagraphi tis stilis me ton arithmo midenikon apo ton pinaka bitBlocks
    bitBlocks(:, 2) = [];
    
    % diagraphi grammon pou den xrisimopoiithikan apo ton pinaka bitBlocks
    bitBlocks(bitBlocks(:,1) == 0, :) = [];
    
    % an ta block pou exoun sintelestes me metro 1 kai arithmo midenikon >= T dn eparkoun gia tin eisagogi tou minimatos tiponoume minima apotixias        
    if sum(bitBlocks(:, 2)) < total_m_len, error("Cannot embed %d bits in image \nMax bits that can be embedded in image: %d \n", total_m_len, sum(bitBlocks(:, 2))); end
end