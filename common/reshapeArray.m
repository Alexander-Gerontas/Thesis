function[new_array] = reshapeArray(array, size1, size2)

    % metatropi enos dianismatos se pinaka distaseon size1 x size2
    if size(array, 1) == 1 || size(array, 2) == 1
       tmp = reshape(array, [size2 size1]);
       new_array = transpose(tmp);
       
    % metatropi enos pinaka se dianisma   
    else        
        tmp = transpose(array);
        new_array = tmp(:);
    end
end