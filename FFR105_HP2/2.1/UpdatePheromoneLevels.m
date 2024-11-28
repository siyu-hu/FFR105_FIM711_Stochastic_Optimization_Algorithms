function pheromoneLevel = UpdatePheromoneLevels(pheromoneLevel, deltaPheromoneLevel, rho)
    pheromoneLevel = (1 - rho) * pheromoneLevel + deltaPheromoneLevel;
    for i = 1:size(pheromoneLevel, 1)
        for j = 1:size(pheromoneLevel, 2)
            if pheromoneLevel(i, j) < 1e-15
                pheromoneLevel(i, j) = 1e-15;
            end
        end
    end
end