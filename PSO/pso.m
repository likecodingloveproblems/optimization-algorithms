function [fval, x, exitflag,output] = pso(N,Max_iter,lb,ub,dim,fobj)
fun = fobj;
nvars = dim;
rng default
%lb = [1,0.5,0.3,0.0018];
%ub = [5,2,1.5,0.01];
options = optimoptions('particleswarm','SwarmSize',N,'MaxIterations',Max_iter);
[x, fval, exitflag,output] = particleswarm(fun, nvars, lb, ub,options);
end