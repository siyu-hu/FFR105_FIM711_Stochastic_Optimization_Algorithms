function mutatedIndividual = Mutate(individual, mutationProbability,numOfOperators, numOfRegisters, numOfConstants )
    chromosome = individual.Chromosome;
    numOfInstructions = size(chromosome , 1);
    numOfA = numOfRegisters + numOfConstants;

    for i = 1: numOfInstructions
        for j = 1: size(chromosome, 2)
            if rand < mutationProbability 
                switch j
                    case 1 
                        newGene = randi([1, numOfOperators]); 
                    case 2  
                        newGene = randi([1, numOfRegisters]);
                    case 3  
                        newGene = randi([1, numOfA]); 
                    case 4  
                        newGene = randi([1, numOfA]); 
                end
                chromosome(i,j) = newGene;
            end
        end
    end
    chromosomeLength = numel(chromosome);
    mutatedIndividual = struct('Chromosome', chromosome, 'Fitness', 0, 'ChromosomeLength', chromosomeLength);
end
