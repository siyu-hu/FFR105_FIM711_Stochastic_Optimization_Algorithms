function population = InitializePopulation(populationSize, numOfInput, numOfHidden, numOfOutput, weightMax)
    chromosomeLength = (numOfHidden * (numOfInput + 1)) + (numOfOutput * (numOfHidden + 1));
    population = zeros(populationSize, chromosomeLength);
    for i = 1: populationSize
        weightInputHidden = rand(numOfHidden, numOfInput+1) * 2 * weightMax - weightMax;
        weightHiddentOutput = rand(numOfOutput, numOfHidden+1) * 2 * weightMax - weightMax;
        chromosome = EncodeNetwork(weightInputHidden, weightHiddentOutput, weightMax);
        population(i,:) = chromosome;
    end
end
