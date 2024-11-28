function selectedIndividualIndex = TournamentSelect(population, populationSize, tournamentProbability, tournamentSize)

    if tournamentSize > populationSize
        error('Tournament size cannot be larger than the population size.');
    end

    tournamentIndex = randi([1, populationSize], 1, tournamentSize);
    tournamentFitness = zeros(1, tournamentSize);
    for i = 1:tournamentSize
        tournamentFitness(i) = population(tournamentIndex(i)).Fitness;
    end

    [~, sortedIndices] = sort(tournamentFitness, 'descend');
    sortedTournamentIndex = tournamentIndex(sortedIndices);

    selected = false;
    
    for i = 1:tournamentSize
        r = rand; % reset r in each comperation step
        if r < tournamentProbability
           selectedIndividualIndex = sortedTournamentIndex(i);
           selected = true;
           break;
        end
    end
    
    % In case, if the for loop cannot choose any individual,
    % then return the least(end) individual
    if (~selected)
        selectedIndividualIndex = sortedTournamentIndex(end);
    end
end
