function res = reorder_points(set, data, x0, y0)
    first_quarter = [];
    second_quarter = [];
    third_quarter = [];
    fourth_quarter = [];
    res = [];
    for i = 1:numel(set)
        if (data(set(i), 1)-x0 == 0 && data(set(i), 2)-y0 == 0)
            phi = 0;
        else
            phi = acos((data(set(i), 1)-x0)/(((data(set(i), 1)-x0)^2+(data(set(i), 2)-y0)^2))^0.5);
        end
        
        if (data(set(i), 1)-x0 > 0 && data(set(i), 2)-y0 >= 0) || (data(set(i), 1)-x0 == 0 && data(set(i), 2)-y0 == 0)
            first_quarter = [first_quarter; 
                            [phi, set(i)]];
        elseif (data(set(i), 1)-x0 <= 0 && data(set(i), 2)-y0 > 0)
            second_quarter = [second_quarter; 
                             [phi, set(i)]];
        elseif (data(set(i), 1)-x0 < 0 && data(set(i), 2)-y0 <= 0)
            third_quarter = [third_quarter; 
                            [phi, set(i)]];
        elseif (data(set(i), 1)-x0 >= 0 && data(set(i), 2)-y0 < 0)
            fourth_quarter = [fourth_quarter; 
                             [phi, set(i)]];
        end
    end
    if ~isempty(first_quarter)
        first_quarter = sortrows(first_quarter,[1],{'ascend'});
        res = [res; first_quarter(:, 2)];
    end
    if ~isempty(second_quarter)
        second_quarter = sortrows(second_quarter,[1],{'ascend'});
        res = [res; second_quarter(:, 2)];
    end
    if ~isempty(third_quarter)
        third_quarter = sortrows(third_quarter,[1],{'descend'});
        res = [res; third_quarter(:, 2)];
    end
    if ~isempty(fourth_quarter)
        fourth_quarter = sortrows(fourth_quarter,[1],{'descend'});
        res = [res; fourth_quarter(:, 2)];
    end
end