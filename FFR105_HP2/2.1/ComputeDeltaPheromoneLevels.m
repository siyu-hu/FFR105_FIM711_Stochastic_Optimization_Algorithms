% Do not symmetrize τij.
function deltaPheromoneLevel = ComputeDeltaPheromoneLevels(pathCollection, pathLengthCollection)
    numberOfCities = size(pathCollection, 2) - 1 ;
    numberOfAnts = size(pathCollection, 1);
    deltaPheromoneLevel = zeros(numberOfCities, numberOfCities);
    
    for k = 1:numberOfAnts
        path = pathCollection(k, :);
        pathLength = pathLengthCollection(k);

        for i = 1:(numberOfCities)
            fromCity = path(i);
            toCity = path(i + 1);
            deltaPheromoneLevel(fromCity, toCity) = deltaPheromoneLevel(fromCity, toCity) + 1 / pathLength; 
        end

    end
end