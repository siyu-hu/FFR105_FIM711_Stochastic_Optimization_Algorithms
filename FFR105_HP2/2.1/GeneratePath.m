% Store path in the tabuList L_T and RETURN to the start city. 
function path = GeneratePath(pheromoneLevel, visibility, alpha, beta)
    numberOfCities = size(pheromoneLevel, 1);
    path = zeros(1, numberOfCities + 1);
    currentCity = randi(numberOfCities);
    path(1) = currentCity;
    tabuList = false(1, numberOfCities);
    tabuList(currentCity) = true;
    
    for step = 2:numberOfCities        
        nextCity = GetNode(currentCity, pheromoneLevel, visibility, tabuList, alpha, beta);
        
        path(step) = nextCity;
        tabuList(nextCity) = true;
        currentCity = nextCity;
    end    
    path(numberOfCities + 1) = path(1);
end
