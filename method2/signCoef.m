function[y] = signCoef(x)

    % i sinartisi sign apo to paper tou Huang16
    if x > 0
        y = 1;
    elseif x == 0
        y = 0;
    elseif x < 0        
        y = -1;
    end
end