% Calculate the probabilities for choosing the next city (Equation 4.3)
% using max(probabilities)
function nextCity = GetNode(currentCity, pheromoneLevel, visibility, tabuList, alpha, beta)
    numberOfCities = length(tabuList);
    probabilities = zeros(1, numberOfCities);

    for city = 1:numberOfCities
        if ~tabuList(city)
            probabilities(city) = (pheromoneLevel(currentCity, city)^alpha) * (visibility(currentCity, city)^beta);
        else
            probabilities(city) = 0;
        end
    end

    totalProbability = sum(probabilities);
    if totalProbability > 0
        probabilities = probabilities / totalProbability;
    else 
        fprintf ('Error: totalProbabilty <= 0, so randomly choose nextCity \n');
        availableCities = find(~tabuList);
        nextCity = availableCities(randi(length(availableCities)));
        return;
    end

    randomValue = rand;
    cumulativeProbability = 0;
    for city = 1:numberOfCities
        if ~tabuList(city)
            cumulativeProbability = cumulativeProbability + probabilities(city);
            if randomValue <= cumulativeProbability
                nextCity = city;
                return;
            end
        end
    end

end
