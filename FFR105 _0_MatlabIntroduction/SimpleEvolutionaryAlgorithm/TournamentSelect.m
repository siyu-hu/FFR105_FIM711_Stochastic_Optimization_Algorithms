% select 2 individuals from population randomly, and if r < pTour, then
% choose the better one, if r > pTour, then choose the worse one.
function iSelected = TournamentSelect(fitness, pTournament)
    populationSize = size(fitness,1); % Do not use length() hare, length will return the max length of all dimentions
    iTmp1 = 1 + fix(rand*populationSize); % why puls one  ? 
    iTmp2 = 1 + fix(rand*populationSize);

    r = rand;
    if (r < pTournament)
        if (fitness(iTmp1) > fitness(iTmp2))
            iSelected = iTmp1;
        else
            iSelected = iTmp2;
        end
    else
        if (fitness(iTmp1) > fitness(iTmp2))
            iSelected = iTmp2;
        else
            iSelected = iTmp1;
        end
    end
end


