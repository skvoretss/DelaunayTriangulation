function plotTriangulation(data, triangles, titleName)
    [cnt_triangles, ~] = size(triangles);
    cur_triangle = zeros(4, 2);
    figure;
    plot(data(:, 1), data(:, 2), '*');
    hold on;
    title(titleName);
    xlabel("x");
    ylabel("y");
    for i = 1:cnt_triangles
        cur_triangle(1, :) = data(triangles(i, 1), :);
        cur_triangle(2, :) = data(triangles(i, 2), :);
        cur_triangle(3, :) = data(triangles(i, 3), :);
        cur_triangle(4, :) = data(triangles(i, 1), :);
        plot(cur_triangle(:, 1), cur_triangle(:, 2));
    end
end