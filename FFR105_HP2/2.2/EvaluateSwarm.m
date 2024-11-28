% Compute the objective function value: f(x1, x2) = (x1^2 + x2 - 11)^2 + (x1 + x2^2 - 7)^2
function fitnessValues = EvaluateSwarm(x)
    numOfParticles = size(x, 1);
    fitnessValues = zeros(numOfParticles, 1);
    for i = 1:numOfParticles
        x1 = x(i, 1);
        x2 = x(i, 2);
        fitnessValues(i) = (x1^2 + x2 - 11)^2 + (x1 + x2^2 - 7)^2;
    end
end