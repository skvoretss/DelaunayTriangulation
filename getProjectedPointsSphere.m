function newData = getProjectedPointsSphere(data, L, r)
    [N, ~] = size(data);
    newData = zeros(N, 3);
    x_center = sum(data(:, 1))/N;
    y_center = sum(data(:, 2))/N;
    for i = 1:N
        if (data(i,1)-x_center ~= 0 && data(i,2)-y_center ~= 0)
            a = ((data(i,1)-x_center)/(data(i,2)-y_center))^2 + 1 + ...
                L^2/(data(i,2)-y_center)^2;
            
            b = -2*y_center*((data(i,1)-x_center)/(data(i,2)-y_center))^2+...
                2*x_center*(data(i,1)-x_center)/(data(i,2)-y_center)-...
                2*y_center*L^2/(data(i,2)-y_center)^2;
            c = (y_center*(data(i,1)-x_center)/(data(i,2)-y_center))^2-...
                2*y_center*x_center*(data(i,1)-x_center)/(data(i,2)-y_center)+...
                x_center^2+y_center^2*L^2/(data(i,2)-y_center)^2 - r^2;
            
            y1 = (-b + (b^2-4*a*c)^(0.5))/(2*a);
            y2 = (-b - (b^2-4*a*c)^(0.5))/(2*a);
            
            z1 = L-L*((y1-y_center)/(data(i,2)-y_center));
            z2 = L-L*((y2-y_center)/(data(i,2)-y_center));
            
            if (z1 < z2)
                x = (y1-y_center)*(data(i,1)-x_center)/(data(i,2)-y_center)+x_center;
                y = y1;
                z = z1;
            else
                x = (y2-y_center)*(data(i,1)-x_center)/(data(i,2)-y_center)+x_center;
                y = y2;
                z = z2;
            end
        elseif (data(i,1)-x_center == 0 && data(i,2)-y_center ~= 0)
            a = 1 + L^2/(data(i,2)-y_center)^2;
            b = -2*y_center*L^2/(data(i,2)-y_center)^2;
            c = x_center^2+y_center^2*L^2/(data(i,2)-y_center)^2 - r^2;
            
            y1 = (-b + (b^2-4*a*c)^(0.5))/(2*a);
            y2 = (-b - (b^2-4*a*c)^(0.5))/(2*a);
            
            z1 = L-L*((y1-y_center)/(data(i,2)-y_center));
            z2 = L-L*((y2-y_center)/(data(i,2)-y_center));
            
            if (z1 < z2)
                x = x_center;
                y = y1;
                z = z1;
            else
                x = x_center;
                y = y2;
                z = z2;
            end
        elseif (data(i,1)-x_center ~= 0 && data(i,2)-y_center == 0)
            a = 1 + L^2/(data(i,1)-x_center)^2;
            b = -2*x_center*L^2/(data(i,1)-x_center)^2;
            c = y_center^2+x_center^2*L^2/(data(i,1)-x_center)^2 - r^2;
            
            x1 = (-b + (b^2-4*a*c)^(0.5))/(2*a);
            x2 = (-b - (b^2-4*a*c)^(0.5))/(2*a);
            
            z1 = L-L*((x1-x_center)/(data(i,1)-x_center));
            z2 = L-L*((x2-x_center)/(data(i,1)-x_center));
            
            if (z1 < z2)
                x = x1;
                y = y_center;
                z = z1;
            else
                x = x2;
                y = y_center;
                z = z2;
            end
        elseif (data(i,1)-x_center == 0 && data(i,2)-y_center == 0)
            x = x_center;
            y = y_center;
            z = L - (r^2-x_center^2-y_center^2)^(0.5);
        end
        newData(i, :) = [x, y, z];
    end
end