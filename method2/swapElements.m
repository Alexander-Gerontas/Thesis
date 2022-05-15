function[new_array] = swapElements(stego_img, pos_array)

    new_array = stego_img;

    % allagi tis thesis ac sinteleston stin eikona me basi tis sintetagmenes apo ton pinaka pos_array
    for i = 1:size(pos_array,1)
       
        x = pos_array(i, 2);
        y = pos_array(i, 3);
        value = pos_array(i, 4);
        
        new_array(x, y) = value;
    end
end