% This function should run the Newton-Raphson method, making use of the
% other relevant functions (StepNewtonRaphson, DifferentiatePolynomial, and
% GetPolynomialValue). Before returning iterationValues any non-plottable values 
% (e.g. NaN) that can occur if the method fails (e.g. if the input is a
% first-order polynomial) should be removed, so that only values that
% CAN be plotted are returned. Thus, in some cases (again, the case of
% a first-order polynomial is an example) there may be no points to plot.


function iterationValues = RunNewtonRaphson(polynomialCoefficients, startingPoint, tolerance)

    %Initialize variables
    currentPoint = startingPoint;
    iterationValues = [startingPoint]; % Array to store the values of each iteration, and add startingPoint at first position
    
   
    %get the fisrt and the seconde derivativation 
    firstDerivative = DifferentiatePolynomial(polynomialCoefficients, 1);
    secondDerivative = DifferentiatePolynomial(polynomialCoefficients, 2);

    % Check if the polynomial is of insufficient degree (e.g., polynomialDegree < 2)
    polynomialDegree = length(polynomialCoefficients) - 1;
    if polynomialDegree < 2
        disp('Error: The degree of the polynomial must be 2 or larger.');
        return; % Exit because there is no valid iteration that can be performed
    end
    
    % Check if firstDerivative is empty, which means polynomial is a constant
    if isempty(firstDerivative)
        disp('Error: The input polynomial is a first-order or constant polynomial, which cannot be handled by the Newton-Raphson method.');
        return;
    end


    if isempty(secondDerivative)
        disp('Error: The secondDerivative is empty (not exist), nextPoint cannot be generated, which cannot be handled by the Newton-Raphson method');
        return; % Exit because there is no valid iteration can be performed
    end
    
    % Iterate until covergence ( x_{j+1} - x_j <= Torlerance)
    % Get the next generation value using the Newton-Raphson method (call the StepNewtonRaphson.m) 

    % Initial check if the first secondDerivative's value is 0
    fDoublePrime = GetPolynomialValue(currentPoint, secondDerivative);
    if fDoublePrime == 0
        disp('Error: The second derivative f''(x) == 0, cannot perform Newton-Raphson step.');
        return;
    end

    while true
    
        fPrime = GetPolynomialValue(currentPoint, firstDerivative);
        fDoublePrime = GetPolynomialValue(currentPoint, secondDerivative);

        % Perform a Newton-Raphson step
        nextPoint = StepNewtonRaphson(currentPoint, fPrime, fDoublePrime);


        % Check if nextPoint value is NaN, which can not be ploted
        if isnan(nextPoint)
            disp('Error: nextPoint is NaN which can not be ploted');
            break; % Stop iteration
        end

        % Store nextPoints
        iterationValues = [iterationValues, nextPoint];
      
        % Check for convergence with specified tolerance
        if abs(nextPoint - currentPoint) <= tolerance
            break; % Convergence achieved
        end

        % Update current point for the next iteration
        currentPoint = nextPoint;

    end


