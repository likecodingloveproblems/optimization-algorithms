
global nt;
nt = 0;
disp('-------------------------------------------------')
disp('-------------------------------------------------')
disp('PSO')
ngpso = [];
nopso = [];
XPSO = [];
cpso = [];
pf = [];


N = 50;
fobj = @cost_Wang_Kulhawy2008;
for i = 1:1
[xpso, fvalpso, exitflagpso,outputpso] = pso(N,Max_iter,lb,ub,dim,fobj);
%psoinfo.i = {[xpso, fvalpso, exitflagpso, outputpso]};
XPSO = [XPSO;xpso];
ngpso = [ngpso; nt];
%g(xpso)
cpso = [cpso cost(xpso)];
nopso = [nopso; outputpso.funccount];
nt = 0; 
end
x = mean(XPSO);
disp('Xmean');
disp(mean(x));
disp('XCoV');
disp(sqrt(var(XPSO))/mean(x));
disp('cost');
disp(mean(cpso));
disp('Pf');
disp(mean(pf));
disp('No');
disp(mean(nopso));
disp('Ng');
disp(mean(ngpso));
disp('CoVNg');
disp(sqrt(var(ngpso))/mean(ngpso));

