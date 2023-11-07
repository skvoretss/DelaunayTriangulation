function triangles = buildTriangulation(data, point1, point2, point3)
    [N, ~] = size(data);

    data = [data; point1];
    data = [data; point2];
    data = [data; point3];

    triangles = [N+1, N+2, N+3];


    if N > 3
        for i = 1:N
            [k, ~] = size(triangles);
            saveNodes = [];
            saveNumber = [];
            x0 = data(i, 1);
            y0 = data(i, 2);
            % for each existing triangle checking if our i-point is in the circle
            for j = 1:k
                x1 = data(triangles(j, 1), 1);
                y1 = data(triangles(j, 1), 2);

                x2 = data(triangles(j, 2), 1);
                y2 = data(triangles(j, 2), 2);

                x3 = data(triangles(j, 3), 1);
                y3 = data(triangles(j, 3), 2);

                A = [x1, y1, 1;
                     x2, y2, 1;
                     x3, y3, 1];
                a = det(A);

                B = [x1^2 + y1^2, y1, 1;
                     x2^2 + y2^2, y2, 1;
                     x3^2 + y3^2, y3, 1];
                b = det(B);

                C = [x1^2 + y1^2, x1, 1;
                     x2^2 + y2^2, x2, 1;
                     x3^2 + y3^2, x3, 1];
                c = det(C);

                D = [x1^2 + y1^2, x1, y1;
                     x2^2 + y2^2, x2, y2;
                     x3^2 + y3^2, x3, y3];
                d = det(D);

                if (a*(x0^2 + y0^2) - b*x0 + c*y0 - d)*sign(a) < 0
                    %save triangles, which must be deleted later
                    saveNodes = [saveNodes; triangles(j, :)];
                    saveNumber = [saveNumber; j];
                end
            end
            triangles(saveNumber, :) = [];
            uniqSaveNodes = unique(saveNodes);
            reorderedNodes = reorder_points(uniqSaveNodes, data, x0, y0);
            reorderedNodes = [reorderedNodes; reorderedNodes(1)];

            s = numel(uniqSaveNodes);
            x_center = 0;
            y_center = 0;
            for j = 1:s
                x_center = x_center + data(uniqSaveNodes(j), 1);
                y_center = y_center + data(uniqSaveNodes(j), 2);
            end
            x_center = x_center/s;
            y_center = y_center/s;
            for j = 1:numel(reorderedNodes)-1
                x1 = data(reorderedNodes(j), 1);
                y1 = data(reorderedNodes(j), 2);
                x2 = data(reorderedNodes(j+1), 1);
                y2 = data(reorderedNodes(j+1), 2);

                rho = (x_center - x1)*(y2-y1)-(y_center-y1)*(x2-x1);
                pos = (x0 - x1)*(y2-y1)-(y0-y1)*(x2-x1);
                if (sign(pos) ~= 0 && sign(pos) == sign(rho))
                    tr = [reorderedNodes(j), reorderedNodes(j+1), i]; 
                    triangles = [triangles; tr];
                end
            end
        end

        [cnt_triangles, ~] = size(triangles);
        removed = [];
        for j = 1:cnt_triangles
            if (~isempty(find(triangles(j, :) == N+1, 1)) || ~isempty(find(triangles(j, :) == N+2, 1)) || ~isempty(find(triangles(j, :) == N+3, 1)))
                removed = [removed, j];
            end
        end
        triangles(removed, :) = [];
        [cnt_triangles, ~] = size(triangles);
        [n, ~] = convhull(data(1:end-3, 1), data(1:end-3, 2));
        point1 = 0;
        point2 = 0;
        for i = 1:numel(n)-1
            point1 = n(i);
            point2 = n(i+1);
            connected = 0;
            for j = 1:cnt_triangles
                if (~isempty(find(triangles(j, :) == point1, 1)) && ...
                        ~isempty(find(triangles(j, :) == point2, 1)))
                    connected = 1;
                    break
                end
            end
            if (connected == 0)
                saveFirstPointTriangles = [];
                saveSecondPointTriangles = [];
                for j = 1:cnt_triangles
                    if ~isempty(find(triangles(j, :) == point1, 1))
                        saveFirstPointTriangles = [saveFirstPointTriangles, ...
                                                   triangles(j, :)];
                    end
                    if ~isempty(find(triangles(j, :) == point2, 1))
                        saveSecondPointTriangles = [saveSecondPointTriangles, ... 
                                                    triangles(j, :)];
                    end
                end
                saveFirstPointTriangles = unique(saveFirstPointTriangles);
                saveSecondPointTriangles = unique(saveSecondPointTriangles);
                res = ismember(saveFirstPointTriangles,...
                               saveSecondPointTriangles);
                tr = [point1, point2, saveFirstPointTriangles(find(res, 1))]; 
                triangles = [triangles; tr];
            end
        end
    end
    %data([N+1, N+2, N+3], :) = [];
end