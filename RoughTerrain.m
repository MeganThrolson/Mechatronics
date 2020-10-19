function z = RoughTerrain(X)
if (X < 11.619)
    z = X*sind(17.5);
elseif (X < 17.625)
    z = 3;
elseif (X < 20.65)
    z = 4;
elseif (X < 22.125)
    z = 3;
elseif (X < 25.125)
    z = 6;
elseif(X < 26.625)
    z = 3;
elseif(X < 19.625)
    z = 5;
elseif(X<35.63)
    z = 3;
else
    z = 3 - (X*sind(17.5));
end