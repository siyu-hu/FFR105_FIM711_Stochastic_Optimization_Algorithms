function selectedIndividualIndex = TournamentSelect(fitnessList, tournamentProbability, tournamentSize)
    populationSize = length(fitnessList);
    

    if tournamentSize > populationSize
        error('Tournament size cannot be larger than the population size.');
    end

    tournamentIndex = randi([1, populationSize], 1, tournamentSize);
    tournamentFitness = fitnessList(tournamentIndex);

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
    % then return the first(best) individual
    if (~selected)
        selectedIndividualIndex = sortedTournamentIndex(end);
    end
end
