disp('--- Testing GetPolynomialValue ---');
% Test: Evaluate a simple polynomial f(x) = 1 + 2x + 3x^2 at x = 2
x = 2;
coefficients = [1, 2, 3];
expectedValue = 1 + 2 * 2 + 3 * 2^2; % Expected result: 17
computedValue = GetPolynomialValue(x, coefficients);
fprintf('Test GetPolynomialValue: Expected: %.2f, Computed: %.2f\n', expectedValue, computedValue);
assert(abs(computedValue - expectedValue) < 1e-6, 'Test GetPolynomialValue failed.');

disp('--- Testing DifferentiatePolynomial ---');
% Test 1: First derivative of f(x) = 1 + 2x + 3x^2
coefficients = [1, 2, 3];
derivativeOrder = 1;
expectedDerivative = [2, 6]; % Expected first derivative: 2 + 6x
computedDerivative = DifferentiatePolynomial(coefficients, derivativeOrder);
fprintf('Test DifferentiatePolynomial (first derivative): Expected: [%s], Computed: [%s]\n', num2str(expectedDerivative), num2str(computedDerivative));
assert(isequal(computedDerivative, expectedDerivative), 'Test DifferentiatePolynomial failed.');

% Test 2: Handle k > n (e.g., k = 3, n = 2)
coefficients = [1, 2];
derivativeOrder = 3; % k > n, should return empty
computedDerivative = DifferentiatePolynomial(coefficients, derivativeOrder);
assert(isempty(computedDerivative), 'Test DifferentiatePolynomial with k > n failed.');

% Test 3: Handle n = 0, k = 0 (constant function)
coefficients = [5]; % f(x) = 5
derivativeOrder = 0;
expectedDerivative = [5];
computedDerivative = DifferentiatePolynomial(coefficients, derivativeOrder);
assert(isequal(computedDerivative, expectedDerivative), 'Test DifferentiatePolynomial with n=0, k=0 failed.');

disp('--- Testing StepNewtonRaphson ---');
% Test: Perform a step with x = 1, fPrime = 4, fDoublePrime = 2
x = 1;
fPrime = 4;
fDoublePrime = 2;
expectedNextX = 1 - 4 / 2; % Expected next x value: -1
computedNextX = StepNewtonRaphson(x, fPrime, fDoublePrime);
fprintf('Test StepNewtonRaphson: Expected: %.2f, Computed: %.2f\n', expectedNextX, computedNextX);
assert(abs(computedNextX - expectedNextX) < 1e-6, 'Test StepNewtonRaphson failed.');

disp('--- Testing RunNewtonRaphson ---');
% Test: Run Newton-Raphson on f(x) = x^2 - 3x + 2, starting at 0.5
coefficients = [2, -3, 1];
startingPoint = 0.5;
tolerance = 1e-6;
try
    iterationValues = RunNewtonRaphson(coefficients, startingPoint, tolerance);
    assert(~isempty(iterationValues), 'Test RunNewtonRaphson failed: no iterations generated.');
    disp('RunNewtonRaphson iteration values:');
    disp(iterationValues);
catch ME
    fprintf('RunNewtonRaphson failed with message: %s\n', ME.message);
end

% Test: Ensure error handling when n < 2
coefficients = [1, 2]; % Linear polynomial, degree < 2
startingPoint = 1;
tolerance = 1e-6;
%try
    RunNewtonRaphson(coefficients, startingPoint, tolerance);
%    disp('Test RunNewtonRaphson failed: Expected error for n < 2 not raised.');
%catch ME
    % Check if the caught error message matches any expected error outputs
%    if contains(ME.message, 'The degree of the polynomial must be 2 or larger.') || ...
%            contains(ME.message, 'The input polynomial is a first-order or constant polynomial.')
%        disp(['Expected error for n < 2: ', ME.message]);
%    else
%        disp(['Unexpected error message: ', ME.message]);
%    end
%end

% Test: Ensure error handling when f''(x) = 0
coefficients = [2, -3, 1, 1]; % Quadratic polynomial
startingPoint = - 1/3 ; % f''(x) = 0 during iteration
tolerance = 1e-6;
%try
    RunNewtonRaphson(coefficients, startingPoint, tolerance);
%    disp('Test RunNewtonRaphson failed: Expected error for f''(x) = 0 not raised.');
%catch ME
    % Check if the caught error message matches the expected error output for f''(x) = 0
%    if contains(ME.message, 'The second derivative f''(x) = 0, cannot perform Newton-Raphson step.')
%        disp(['Expected error for f''(x) = 0: ', ME.message]);
%    else
%        disp(['Unexpected error message: ', ME.message]);
%    end
%end

disp('--- Testing PlotIterations ---');
% Test the plotting function with the values obtained from the above test
PlotIterations(coefficients, iterationValues);
disp('Test PlotIterations: Check the generated plot for correctness.');

disp('All tests completed.');
