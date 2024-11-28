% For input chromosome and Prob. of mutation intialed in the main funciton,
% randomly set r , if r < mutation Prob, then change the Gene to another values
% else, do noting, until checked all the genes in this chromosome

function mutatedChromosome = Mutate(chromosome,mutationProbability)
    nGenes = size(chromosome,2);
    mutatedChromosome = chromosome;
    for j = 1:nGenes
        r = rand; % for every loop , the r is changed! 
        if (r < mutationProbability)
            mutatedChromosome(j) = 1 - chromosome(j);
        end
    end
end