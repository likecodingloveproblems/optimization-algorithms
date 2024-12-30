clc
disp('-------------------------------------------------')
disp('-------------------------------------------------')
disp('ECBO')
ngecbo = [];
noecbo = [];
XECBO = [];
cecbo = [];
pf = [];
global nt
nt = 0;
lb = [1,0.5,0.4,1,1,1,1,1];
ub = [3,2,1.5,11,7,5,3,5];
for i = 1:1
[xecbo,Cost,Convergence_curve] = ECBO(30,100,lb,ub,8,@cost_Wang_Kulhawy2008);
XECBO = [XECBO;xecbo];
ngecbo = [ngecbo; nt];
% input(xecbo);
pf = [pf Reliability()];
cecbo = [cecbo Cost];
nt = 0;
end
x = mean(XECBO);
disp('Xmean');
disp(mean(x));
disp('XCoV');
disp(sqrt(max(var(XECBO)))/mean(x));
disp('cost');
disp(mean(cecbo));
disp('Pf');
disp(mean(pf));
disp('Ng');
disp(mean(ngecbo));
disp('CoVNg');
disp(sqrt(var(ngecbo))/mean(ngecbo));




