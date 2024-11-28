%in this case function fitness = EvaluateIndividual (define in the FunctionOptimization.m) 
% = f (for combine the poly of f(x,y))  =  f(x,y) define in the Question description) 
% because we are finding the Maximum of f(x,y), 
% higher function values also means higher fitness 

function f = EvaluateIndividual(x) 
    fNumerator1 = exp(-x(1)^2 - x(2)^2);
    fNumerator2 = sqrt(5)*(sin(x(2)*x(1)*x(1))^2);
    fNumerator3 = 2*(cos(2*x(1) + 3*x(2))^2);

    fDenominator = 1 + x(1)^2 + x(2)^2;

    f = (fNumerator1 + fNumerator2 + fNumerator3)/fDenominator; 
end

