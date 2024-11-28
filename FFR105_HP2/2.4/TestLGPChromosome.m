function TestLGPChromosome()
    run('BestChromosome.m');
    functionData = LoadFunctionData();

    syms r1 r2 r3 x
    constants = [-10, -1, 0, 0.5, 1];

    r1 = x; 
    r2 = sym('r2');
    r3 = sym('r3');
    operators = {'+', '-', '*', '/'};

    for i = 1:size(bestOverallIndividual.Chromosome, 1)
        operatorIdx = bestOverallIndividual.Chromosome(i, 1);
        destIdx = bestOverallIndividual.Chromosome(i, 2);
        operand1Idx = bestOverallIndividual.Chromosome(i, 3);
        operand2Idx = bestOverallIndividual.Chromosome(i, 4);

        if operand1Idx <= 3
            operand1 = eval(['r' num2str(operand1Idx)]);
        else
            operand1 = constants(operand1Idx - 3);
        end

        if operand2Idx <= 3
            operand2 = eval(['r' num2str(operand2Idx)]);
        else
            operand2 = constants(operand2Idx - 3);
        end

        switch operators{operatorIdx}
            case '+'
                result = operand1 + operand2;
            case '-'
                result = operand1 - operand2;
            case '*'
                result = operand1 * operand2;
            case '/'
                result = operand1 / operand2;
        end
        eval(['r' num2str(destIdx) ' = result;']);
    end

    g_x = simplify(r1);
    disp('Estimated Function g(x):');
    pretty(g_x);
    disp(['g(x) = ' char(g_x)]);

    x_values = functionData(:, 1); 
    y_data = functionData(:, 2); 

    y_hat = arrayfun(@(v) double(subs(g_x, x, v)), x_values);

    error = sqrt(mean((y_hat - y_data).^2));
    fprintf('Root Mean Squared Error: %.4f\n', error);

    figure;
    plot(x_values, y_data, 'b-', 'DisplayName', 'Original Data');
    hold on;
    plot(x_values, y_hat, 'r--', 'DisplayName', 'Best Fit');
    xlabel('Input X');
    ylabel('Output Y');
    legend show;
    title('Original Data vs Best Fit');
    hold off;
end
