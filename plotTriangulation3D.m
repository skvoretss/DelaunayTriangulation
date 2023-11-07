function plotTriangulation3D(data, triangles, titleName)
    [cnt_triangles, ~] = size(triangles);
    cur_triangle = zeros(4, 3);
    figure;
    plot3(data(:, 1), data(:, 2), data(:, 3), '*');
    hold on;
    grid on;
    title(titleName);
    xlabel("x");
    ylabel("y");
    for i = 1:cnt_triangles
        cur_triangle(1, :) = data(triangles(i, 1), :);
        cur_triangle(2, :) = data(triangles(i, 2), :);
        cur_triangle(3, :) = data(triangles(i, 3), :);
        cur_triangle(4, :) = data(triangles(i, 1), :);
        plot3(cur_triangle(:, 1), cur_triangle(:, 2), cur_triangle(:, 3));
    end
end