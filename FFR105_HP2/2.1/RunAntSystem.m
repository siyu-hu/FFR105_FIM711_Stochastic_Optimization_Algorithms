%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FFR105 HP2.2 PSO
% Ant system (AS) for TSP.
% Author: Siyu HU, gushusii@student.gu.se, 19950910-3702
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
clc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cityLocation = LoadCityLocations();
numberOfCities = length(cityLocation);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
numberOfAnts = 50;  %% Changes allowed
alpha = 1.0;        %% Changes allowed
beta = 3.0;         %% Changes allowed
rho = 0.3;          %% Changes allowed
tau0 = 0.1;         %% Changes allowed

targetPathLength = 99.9999999; 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initialization
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% To do: Add plot initialization
range = [0 20 0 20];
tspFigure = InitializeTspPlot(cityLocation, range);
connection = InitializeConnections(cityLocation);
pheromoneLevel = InitializePheromoneLevels(numberOfCities, tau0); % To do: Write the InitializePheromoneLevels
visibility = GetVisibility(cityLocation);                         % To do: write the GetVisibility function

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Main loop
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
minimumPathLength = inf;

iIteration = 0;
pathCollection = zeros(numberOfAnts, numberOfCities +1);
pathLengthCollection = zeros(numberOfAnts,1);

while (minimumPathLength > targetPathLength)
 iIteration = iIteration + 1;

 %%%%%%%%%%%%%%%%%%%%%%%%%%
 % Generate paths:
 %%%%%%%%%%%%%%%%%%%%%%%%%%

 for k = 1:numberOfAnts
  path = GeneratePath(pheromoneLevel, visibility, alpha, beta);   % length = 51 To do: Write the GeneratePath function
  pathLength = GetPathLength(path,cityLocation);                  % length = To do: Write the GetPathLength function
  if (pathLength < minimumPathLength)
    minimumPathLength = pathLength;
    
    PlotPath(connection,cityLocation,path);
    bestPath = path(1:end-1); 
  end
  pathCollection(k,:) = path;  
  pathLengthCollection(k) = pathLength; 
 end

 %%%%%%%%%%%%%%%%%%%%%%%%%%
 % Update pheromone levels
 %%%%%%%%%%%%%%%%%%%%%%%%%%

 deltaPheromoneLevel = ComputeDeltaPheromoneLevels(pathCollection,pathLengthCollection);  % To do: write the ComputeDeltaPheromoneLevels function
 pheromoneLevel = UpdatePheromoneLevels(pheromoneLevel,deltaPheromoneLevel,rho);          % To do: write the UpdatePheromoneLevels function


end

fprintf('Iteration %d, ant %d: path length = %.5f',iIteration,k,minimumPathLength);
fileID = fopen('BestResultFound.m', 'w');
fprintf(fileID, 'bestPath = [%s];\n', num2str(bestPath));
fclose(fileID);


