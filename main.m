clc;
data = load("data.txt");
H = 7;
L = 4;
r = 3;
point1 = [-20, 15];
point2 = [20, 15];
point3 = [0, -25];

triangles = buildTriangulation(data, point1, point2, point3);
plotTriangulation(data, triangles, "Delaunay triangulation");

newData = getProjectedPointsCircle(data, H, L);
plotTriangulation(newData, triangles, "Delaunay triangulation for projected points");

newData = getProjectedPointsSphere(data, L, r);
plotTriangulation3D(newData, triangles, "Delaunay triangulation for projected points");