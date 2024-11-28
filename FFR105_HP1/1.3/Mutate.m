function mutatedIndividual = Mutate(individual, mutationProbability)
    individualLength = length(individual);
    mutatedIndividual = individual;

    for i = 1:individualLength
        r = rand;
        if r < mutationProbability
            mutatedIndividual(i) = 1 - individual(i); 
        end
    end

end
