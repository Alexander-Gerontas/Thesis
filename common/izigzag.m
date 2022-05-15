function[block] = izigzag(zigBlock)        

    % dimiourgia pinaka gia tin apothikeusi tou block meta ton antistrofo zigzag
    block = zeros(8, 8);
   
    i = 1; j = 1; z = 2;
        
    block(1,1) = zigBlock(1);
               
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
        
        block(i,j) = zigBlock(z);
        z = z+1;
                
        % diasxisi tou block diagonia pros ta kato kai ekxorisi timon apo to dianisma
        while(j-1 > 0 && i < size(block,1))            
            i = i + 1;
            j = j - 1;
                        
            block(i,j) = zigBlock(z);
            z = z+1;            
        end
        
        if i < size(block,1)
            i = i+1;
        else
            j = j + 1;
        end
            
        block(i,j) = zigBlock(z);
        z = z+1;
        
        % diasxisi tou block diagonia pros ta pano kai ekxorisi timon apo to dianisma 
        while(j < size(block, 2) && i-1 > 0)
            i = i - 1;
            j = j + 1;            
            
            block(i,j) = zigBlock(z);
            z = z+1;            
        end
    end
end