function[vector] = str2vector(str)

    vector = zeros(1, length(str));

    % metatropi kathe xaraktira se akaireo kai apothikeusi sto dianisma vector
    for i = 1:length(str)
       vector(i) = str2double(str(i));
    end
end