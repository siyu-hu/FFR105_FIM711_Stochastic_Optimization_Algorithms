% Plot log contour of the objective function f(x1, x2)
function PlotLogContour()
    f = @(x1, x2) (x1.^2 + x2 - 11).^2 + (x1 + x2.^2 - 7).^2;
    a = 0.01; 
    f_log = @(x1, x2) log(a + f(x1, x2));
    [tempX1, tempX2] = meshgrid(-5:0.1:5, -5:0.1:5);
    Z = f_log(tempX1, tempX2);
    contour(tempX1, tempX2, Z, 50);  
    colorbar; 
    title('Contour plot of log(a + f(x1, x2)) with all minima');
    xlabel('x1');
    ylabel('x2');
end
