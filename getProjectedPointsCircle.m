function newData = getProjectedPointsCircle(data, H, L)
    [N, ~] = size(data);
    newData = zeros(N, 2);
    x_center = sum(data(:, 1))/N;
    y_center = sum(data(:, 2))/N;
    for i = 1:N
        x = x_center;
        y = y_center;
        % get the equation of the line
        if (data(i,1)-x_center ~= 0 && data(i,2)-y_center ~= 0)
            x = (H-L)/H*(data(i,1)-x_center)+x_center;
            y = (H-L)/H*(data(i,2)-y_center)+y_center;
        elseif (data(i,1)-x_center == 0 && data(i,2)-y_center ~= 0)
            x = x_center;
            y = (H-L)/H*(data(i,2)-y_center)+y_center;
        elseif (data(i,1)-x_center ~= 0 && data(i,2)-y_center == 0)
            x = (H-L)/H*(data(i,1)-x_center)+x_center;
            y = y_center;
        end
        newData(i, :) = [x, y];
    end
end