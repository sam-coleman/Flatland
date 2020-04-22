function [f, fn, gradient, r, gradient_num] = gradientAscent(f, rx0, ry0, xmin, xmax, ymin, ymax, delta, lambda0) %how can f be an input?
    %parameters
    %r0 is inital position (rx0 and ry0)
    %xmin is x lower bound
    %xmax is x upper bound
    %ymin is y lower bound
    %ymax is y upper bound
    %f is function of x and y
    %delta and lambda are used for lamda(i+1) = delta*lambda(i)

syms x y 
f_sym = matlabFunction(f);
[xn, yn] = meshgrid(xmin:.2:xmax, ymin:.2:ymax);
fn = f_sym(xn, yn);

%determine symbolic gradient
px = diff(f, x);
py = diff(f, y);
gradient = [px, py];

prop = delta * lambda0;

%do first step
r = [rx0, ry0];
gradient_num = double(subs(gradient, [x, y], [r(1, 1), r(1, 2)]));
num_row = 1;

%plot contour
figure(), clf
hold on
contourf(xn, yn, fn)
plot(r(1, 1), r(1, 2), '*k')
colorbar

while prop > .01
    num_row = num_row + 1 %show the incramenting
    
    %determine next point and plot
    gradient_num(num_row, :) = double(subs(gradient, [x, y], [r(num_row-1, 1), r(num_row-1, 2)]));
    r(num_row, :) = r(num_row-1, :) + prop(num_row-1) * gradient_num(num_row-1, :);
    prop(num_row) = delta * prop(num_row-1);
    plot(r(num_row, 1), r(num_row, 2), '*k')
end
xlim([xmin xmax])
ylim([ymin ymax])
hold off
end