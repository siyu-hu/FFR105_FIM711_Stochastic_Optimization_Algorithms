clear all;

populationSize = 30;
numberOfGenes = 40;
crossoverProbability = 0.8;
mutationProbability = 0.025;
tournamentSelectionParameter = 0.75;
numberOfGenerations = 100;  
variableRange = 3.0;
fitness = zeros(populationSize, 1);

% Graphics
fitnessFigureHandle = figure;
hold on;
set(fitnessFigureHandle, 'Position', [50,50,500,200]); set(fitnessFigureHandle, 'DoubleBuffer','on');
axis([1 numberOfGenerations 2.5 3]);
bestPlotHandle = plot(1:numberOfGenerations,zeros(1,numberOfGenerations)); 
textHandle = text(30,2.6,sprintf('best: %4.3f',0.0));
hold off;
drawnow;

surfaceFigureHandle = figure;
hold on;
set(surfaceFigureHandle, 'DoubleBuffer','on');
delta = 0.1;
limit = fix(2*variableRange/delta) + 1;
[xValues,yValues] = meshgrid(-variableRange:delta:variableRange,-variableRange:delta:variableRange);
zValues = zeros(limit,limit);
for j = 1: limit 
    for k = 1: limit
        zValues(j,k)= EvaluateIndividual([xValues(j,k) yValues(j,k)]);
    end
end
surfl(xValues,yValues,zValues)
colormap gray;
shading interp;
view([-7 -9 10]);
decodedPopulation = zeros(populationSize,2);
populationPlotHandle = plot3(decodedPopulation(:,1),decodedPopulation(:,2),fitness(:),'kp');
hold off;
drawnow; 


% Main Function of Optimization 
population = InitializePopulation(populationSize, numberOfGenes);

% Evaluation with Elitism : to achieve monotonous increase in Fitness, 
% keep track of the best individual and insert a copy of this individual at
% the first position of new population
%
% Original code for Evaluation without Elitism and loop of
% numberOfGenerations
% for i = 1:populationSize
%   chromosome = population(i,:); 
%   x = DecodeChromosome(chromosome, variableRange);
%    fitness(i) = EvaluateIndividual(x);
% end

for iGeneration = 1:numberOfGenerations
    maximumFitness = 0.0; % Assumes non−negative fitness values!
    xBest = zeros(1,2); % [0 0]
    bestIndividualIndex = 0;
    for i = 1:populationSize
        chromosome = population(i,:);
        x = DecodeChromosome(chromosome, variableRange);
        fitness(i) = EvaluateIndividual(x);
        if (fitness(i) > maximumFitness) % compare fitness one by one
            maximumFitness = fitness(i);
            bestIndividualIndex = i;
            xBest = x;
        end
    end
    
    % Printout - if output the graphic straightly, it dosent need disp every generation
    % anymore.
    %disp('xBest');
    %disp(xBest);
    %disp('maximumFitness');
    %disp(maximumFitness);
        
    % Form the next generation:
    % Step 1 Selection: randomly choose 2 individuals and run the tournament
    % selection, untill all the individuals are replaced by the next
    % generation(temporary generation, needed be crossed and mutate) 
    % Step 2 Crossover: set Random r and Pcross(typically 0.7-0.8), if r < Pcross,
    % run the crosser operator, else no change happens.
    
    tempPopulation = population;
    
    for i = 1:2:populationSize % 1= start point ; 2 = interval(2 chromosomes,x, y) ; populationSize = end point
       
        i1 = TournamentSelect(fitness,tournamentSelectionParameter); 
        i2 = TournamentSelect(fitness,tournamentSelectionParameter);
        chromosome1 = population(i1,:); 
        chromosome2 = population(i2,:); 
        tempPopulation(i,:) = chromosome1; 
        tempPopulation(i+1,:) = chromosome2;
        
        %Call crossover operator
        r = rand;
        if (r < crossoverProbability)
            newChromosomePair = Cross(chromosome1,chromosome2); 
            tempPopulation(i,:) = newChromosomePair(1,:); 
            tempPopulation(i+1,:) = newChromosomePair(2,:);
        else
            tempPopulation(i,:) = chromosome1;
            tempPopulation(i+1,:) = chromosome2;
        end
    end % Loop over population

    % Step 3 : Mutation; for each chromosome（number of chromosome = size of population）,  
    % if random r < prob. of mutation , then change the value of gene; else do nothing. And store
    % the new chromosom after checking all genes contained in all chromosomes     .
    for i = 1:populationSize
        originalChromosome = tempPopulation(i,:); 
        mutatedChromosome = Mutate(originalChromosome,mutationProbability); 
        tempPopulation(i,:) = mutatedChromosome;
    end
    
    % "insert" the bestPopulation, in fact, it is "overwriting" the first position 
    tempPopulation(1,:) = population(bestIndividualIndex,:);
    
    % the temporary population replaces the original population,  forming a generation is finished.
    population = tempPopulation; 

    plotvector = get(bestPlotHandle,'YData');
    plotvector(iGeneration) = maximumFitness;
    set(bestPlotHandle,'YData',plotvector);
    set(textHandle,'String',sprintf('best: %4.3f',maximumFitness));
    set(populationPlotHandle,'XData',decodedPopulation(:,1),'YData', decodedPopulation(:,2),'ZData',fitness(:));
    drawnow;

end % loop over generations

% Print final result
format long;
disp('xBest');
disp(xBest);
disp('maximumFitness');
disp(maximumFitness);

