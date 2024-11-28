function pathLength = GetPathLength(path, cityLocation)
    pathLength = 0;
    numberOfCities = length(path) - 1;  
    for i = 1:numberOfCities
        fromCity = path(i);
        toCity = path(i + 1);
        distance = sqrt((cityLocation(fromCity, 1) - cityLocation(toCity, 1))^2 + (cityLocation(fromCity, 2) - cityLocation(toCity, 2))^2);
        pathLength = pathLength + distance;
    end
end