% This method should plot the polynomial and the iterates obtained
% using NewtonRaphsonStep (if any iterates were generated).

function PlotIterations(polynomialCoefficients, iterationValues)
    % Define the range for polting the polynomial
    xRange = linspace(1 , max(iterationValues) + 0.25 , 1000); % Expand range slightly beyond iterates
    yValues = zeros(size(xRange)); % Compute f(x) values of the polynomial

    % Calculate the polynomial values f(x) = yValues 
    for i = 1 :length(xRange)
        yValues(i) = GetPolynomialValue(xRange(i),polynomialCoefficients);
    end

    % plot f(x) curve
    figure; % Create a new figure
    plot(xRange, yValues, 'green', 'LineWidth', 1.5); % Plot polynomial curve in blue
    hold on; % Hold the current plot to add iterateValues

   % plot iterateValues & f(x)
   iterationYValue = zeros(length(iterationValues), 1);
   for j = 1: length(iterationValues)
      iterationYValue(j) = GetPolynomialValue(iterationValues(j), polynomialCoefficients);   
   end
   
   plot(iterationValues, iterationYValue,'*r');

   xlabel('x');
   ylabel('f(x)');
   hold off;

end







