function[stego_img, S, T] = dataEmbedding(dct_image, blocks, o1, o2, m)
      
    b = blocks - 1;

    stego_img = dct_image;
        
    % epilogi ton block gia tin eisagogi minimatos kai euresi ton parametron S, T
    [dataBlock, S, T] = selectEmbeddingBlocks(dct_image, blocks, o1, o2, m);
     
    % ean mporoun na enthethoun parapano bit apo osa theloume eisagoume midenika sto telos tou minimatos
    bits_to_remove = sum(dataBlock(:, 3)) - length(m(:));
    
    bits_to_be_embedded = zeros(1, length(m(:)) + bits_to_remove);
    bits_to_be_embedded(1:length(m(:))) = m;
    
    % briskoume tin thesi tou dc sintelesti kathe block
    block_start = getBlockIndex(dct_image, blocks);
    
    i = 0;    
    
    % epanalipsi gia ola ta block pou epilexthikan gia tin eisagogi
    while i < size(dataBlock, 1)    
        
        i = i + 1;
        
        % briskoume ton arithmo tou block apo tin 1i stili tou pinaka
        block_num = dataBlock(i, 1);
        
        % briskoume tis sintetagmenes tou dc coef tou block
        x = block_start(block_num, 1);
        y = block_start(block_num, 2);

        % apothikeusi tou block se enan pinaka
        jpeg_block = zeros(blocks, blocks);
        jpeg_block(1:blocks, 1:blocks) = dct_image(x:x+b, y:y+b);

        % euresi tou arithmou ton bit pou mporoun na enthethoun sto block
        number_of_bits_to_be_embedded_in_block = dataBlock(i, 3);
        
        % apothikeusi ton bit pou prokeitai na enthethoun se ena dianisma
        bits_to_be_embedded_in_block = bits_to_be_embedded(1:number_of_bits_to_be_embedded_in_block);
        
        % enthesi ton bit sto block
        [new_block, bits_embedded] = histPairDataEmbedding(jpeg_block, bits_to_be_embedded_in_block, number_of_bits_to_be_embedded_in_block, S, T, o1, o2);
                                       
        % diagraphi ton bit pou exoun eisaxthei apo to dianisma me ta bit pou prokeitai na eisaxthoun
        bits_to_be_embedded = bits_to_be_embedded(bits_embedded+1:end);

        % apothikeusi tou block meta tin enthesi bit stin stego eikona
        stego_img(x:x+b, y:y+b) = new_block;        
    end
end