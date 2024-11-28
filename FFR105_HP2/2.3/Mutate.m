function mutatedIndividual = Mutate(individual, mutationProbability)
    mutatedIndividual = individual; 
    numGenes = length(individual);  
    for j = 1:numGenes
        r = rand;  
        if r < mutationProbability
            mutatedIndividual(j) = max(0, min(1,mutatedIndividual(j) + randn * 0.2));     
        end
    end
end
