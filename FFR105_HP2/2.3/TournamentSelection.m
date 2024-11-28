function selectedIndividualIndex = TournamentSelection(fitnessList, tournamentProbability, tournamentSize)
    populationSize = length(fitnessList);

    if tournamentSize > populationSize
        error('Tournament size cannot be larger than the population size.');
    end

    tournamentIndices = randi([1, populationSize], 1, tournamentSize);
    tournamentFitness = fitnessList(tournamentIndices);

    [~, sortedIndices] = sort(tournamentFitness, 'descend');
    sortedTournamentIndices = tournamentIndices(sortedIndices);

    for i = 1:tournamentSize
        r = rand; 
        if r < tournamentProbability
            selectedIndividualIndex = sortedTournamentIndices(i);
            return;
        end
    end

    selectedIndividualIndex = sortedTournamentIndices(end);
end
