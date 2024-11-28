function population = InitializePopulation(populationSize, minChromosomeLength, maxChromosomeLength, numOfOperators, numOfRegisters, constants)
    population(populationSize) = struct('Chromosome', [], 'Fitness', 0, 'ChromosomeLength', 0);
    numOfA = numOfRegisters + length(constants);

    for i = 1:populationSize
        chromosomeLength = minChromosomeLength + fix(rand * (maxChromosomeLength - minChromosomeLength + 1));
        chromosomeLength = chromosomeLength - mod(chromosomeLength, 4);  % Each instruction contains 4 genes
        instructionsLength = chromosomeLength / 4; 
        tmpChromosome = zeros(instructionsLength, 4); 

        for j = 1:instructionsLength
            tmpChromosome(j, 1) = randi(numOfOperators);
            tmpChromosome(j, 2) = randi(numOfRegisters);
            tmpChromosome(j, 3) = randi([1, numOfA]);
            tmpChromosome(j, 4) = randi([1, numOfA]);
        end

        tmpIndividual = struct('Chromosome', tmpChromosome, 'Fitness', 0, 'ChromosomeLength', chromosomeLength);
        population(i) = tmpIndividual;
    end
end
