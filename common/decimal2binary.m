function[binary] = decimal2binary(decimal)

    % metatropi thetikou arithmou sto diadiko
    if decimal > 0        
        binary = dec2bin(decimal);
        return;
       
    % metatropi arnitikou arithmou sto diadiko   
    elseif decimal < 0        
         
        % metatropi arithmou sto diadiko
        tmp_bin = dec2bin(abs(decimal));
                
        % metatropi ton midenikon se assous, kai ton asson se midenika
        tmp_bin(tmp_bin == '0') = '3';        
        tmp_bin(tmp_bin == '1') = '0';
        tmp_bin(tmp_bin == '3') = '1';
        
        binary = tmp_bin;
                
    else, binary = ''; 
    
    end
end