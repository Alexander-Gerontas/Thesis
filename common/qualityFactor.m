function[newQuantTable] = qualityFactor(quantTable, Q)
    
    % ypologismos tis timis S me basi to quality factor pou epilexthike
    if Q < 50 
        S = 5000 / Q;
    else        
        S = 200 - 2*Q;
    end
        
    % ypologismos tou pinaka kbantismou 
    newQuantTable = floor((50 + S * quantTable)/ 100);
    
    % ta stoixeia tou pinaka dn mporoun na exoun mideniki timi opote dinoume stis midenikes times tou pinaka tin timi 1
    newQuantTable(newQuantTable == 0) = 1;
end