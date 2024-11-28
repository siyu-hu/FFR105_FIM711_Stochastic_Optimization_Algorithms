% Crossover Operator Function:
% For selected 2 individuals, set randomly crossover point, Prob. of cross is
% initialed in the main file. 
% For g_1 to g_crossPoiont, no change happpens.
% For g_crossPoint+1 to the end, NewChro(1) = OldChro(2); NewChro(2)=NewChro(1)

function newChromosomePair = Cross(chromosome1,chromosome2)
    nGenes = size(chromosome1,2); % Both chromosomes must have the same length!
    crossoverPoint = 1 + fix(rand*(nGenes-1));
    newChromosomePair = zeros(2,nGenes); % store 2 new chromosome after crossing

    for j = 1:nGenes
        if (j <= crossoverPoint)
            newChromosomePair(1,j) = chromosome1(j);
            newChromosomePair(2,j) = chromosome2(j);
        else
            newChromosomePair(1,j) = chromosome2(j);
            newChromosomePair(2,j) = chromosome1(j);
        end
    end
end

