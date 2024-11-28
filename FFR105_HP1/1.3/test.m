population = InitializePopulation(50, 32);

%---- DecodeChromosome ----
chromosome = [1 0 1 1 0 0 1 1];  % 二进制染色体
numberOfVariables = 2;           % 两个变量 =  2 genes  = x1,  x2
maximumVariableValue = 5;        % 每个变量的取值范围 [-5, 5]
x = DecodeChromosome(chromosome, numberOfVariables, maximumVariableValue);
disp(x);

%---- EvaluateIndividual ----


fitness = EvaluateIndividual([1, 2]);
disp(fitness);


%---- TournamentSelect----

fitnessList = [0.1, 0.5, 0.2, 0.8, 0.6]; % 种群的适应度值
tournamentProbability = 0.8; % 80% 的概率选择最优个体
tournamentSize = 4; % 每次锦标赛随机选择4个个体

selectedIndex = TournamentSelect(fitnessList, tournamentProbability, tournamentSize);
disp(['Selected individual index: ', num2str(selectedIndex)]);

%---- Cross ----

individual1 = [1 0 1 1 0 1 0 1]; % 父代个体1
individual2 = [0 1 0 0 1 0 1 0]; % 父代个体2

newIndividuals = Cross(individual1, individual2);
disp('New Individuals:');
disp(newIndividuals);

%---- test stationary point ----

x_1 = 3.0000039339;
x_2 = 0.5000005811;

grad_f_x1 = 2 * (1.5 - x_1 + x_1* x_2) *(-1 + x_2) + 2 * (2.25 - x_1 + x_1 * x_2^2) * (-1 + x_2^2) + 2 * (2.625 - x_1 + x_1 *x_2^3) *(-1 + x_2^3);
grad_f_x2 = 2 * (1.5 - x_1 + x_1 * x_2) * x_1 + 2 * (2.25 - x_1 + x_1* x_2^2) *2 * x_1 * x_2 + 2 * (2.625 - x_1 + x_1 * x_2^3) * 3 * x_1 * x_2^2;

disp(grad_f_x1);
disp(grad_f_x2)

% 给定的 x1 和 x2 值
x1 = 3.0000000596;
x2 = 0.4999999851;

% 计算偏导数 ∂g/∂x1
partial_g_x1 = 2 * ((1.5 - x1 + x1 * x2) * (-1 + x2) + ...
                    (2.25 - x1 + x1 * x2^2) * (-1 + x2^2) + ...
                    (2.625 - x1 + x1 * x2^3) * (-1 + x2^3));

% 计算偏导数 ∂g/∂x2
partial_g_x2 = 2 * ((1.5 - x1 + x1 * x2) * x1 + ...
                    (2.25 - x1 + x1 * x2^2) * 2 * x1 * x2 + ...
                    (2.625 - x1 + x1 * x2^3) * 3 * x1 * x2^2);

% 显示结果
fprintf('∂g/∂x1 at (x1, x2) = (%f, %f): %f\n', x1, x2, partial_g_x1);
fprintf('∂g/∂x2 at (x1, x2) = (%f, %f): %f\n', x1, x2, partial_g_x2);
