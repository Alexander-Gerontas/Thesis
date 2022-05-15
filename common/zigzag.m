function[zigBlock] = zigzag(block)

    % dimiourgia pinaka gia tin apothikeusi tou block meta to zigzag
    zigBlock = zeros(1, length(block(:)));
       
    % times gia tin prospelasi tou pinaka
    i = 1; j = 1; z = 2;
        
    zigBlock(1) = block(1,1);
    
    % epanalipsi mexri na ftasoume sto teleutaio keli sto block
    while(i <= size(block,1) && j <= size(block,2))   
        
        % enimeronoume tis times i, j frontizontas na min ksepernoun tis diastaseis tou block
        if j < size(block,2)
            j = j + 1;
        elseif i < size(block,1)
            i = i + 1;
        else
            break;            
        end
        
        zigBlock(z) = block(i,j);
        z = z+1;
                
        % diasxisi kai apothikeusi ton timon tou block diagonia pros ta kato
        while(j-1 > 0 && i < size(block,1))            
            i = i + 1;
            j = j - 1;
                                             
            zigBlock(z) = block(i,j);
            z = z+1;            
        end
        
        % enimeronoume tis times i, j frontizontas na min ksepernoun tis diastaseis tou block        
        if i < size(block,1)
            i = i+1;
        else
            j = j + 1;
        end            
     
        zigBlock(z) = block(i,j);
        z = z+1;
        
        % diasxisi kai apothikeusi ton timon tou block diagonia pros ta pano
        while(j < size(block, 2) && i-1 > 0)
            i = i - 1;
            j = j + 1;            
                               
            zigBlock(z) = block(i,j);
            z = z+1;            
        end
    end
end