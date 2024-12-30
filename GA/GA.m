function [fval, x, exitflag,output] = GA(N,Max_iter,lb,ub,dim,fobj)
fun = fobj;
nvars = dim;
rng default
options = optimoptions('ga','PopulationSize',N,'MaxGenerations',Max_iter);
[x, fval, exitflag,output] = ga(fun, nvars,[],[],[],[], lb, ub,[],options);
end