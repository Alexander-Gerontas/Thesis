function[sorted_pos_array] = updatedAcCoord(stego_img, old_pos_array)

    shuffled_pos_array = old_pos_array;

    % enimerosi tis 4hs stilis tou pinaka me tin nea timi tou ac sintelesti
    for i = 1:size(old_pos_array,1)
        
        x = old_pos_array(i, 2);
        y = old_pos_array(i, 3);
        
        shuffled_pos_array(i, 4) = stego_img(x, y);       
    end
    
    % taksinomisi tou pinaka me basi tou index stin 1h stili
    tmp = sortrows(shuffled_pos_array, 1);
    sorted_pos_array = tmp;
    
    % oi sintetagmenes menoun idies
    sorted_pos_array(:, 2) = shuffled_pos_array(:, 2);
    sorted_pos_array(:, 3) = shuffled_pos_array(:, 3);
end