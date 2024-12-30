clc
disp('-------------------------------------------------')
disp('-------------------------------------------------')
disp('CBO')
ngcbo = [];
nocbo = [];
XCBO = [];
ccbo = [];
pf = [];
global nt
nt = 0;
lb = [1,0.5,0.3,0.0018];
ub = [10,3,2,0.01];
for i = 1:1
[xcbo,Cost] = CBO(30,100,lb,ub,4,@cost);
XCBO = [XCBO;xcbo];
ngcbo = [ngcbo; nt];
ccbo = [ccbo Cost];
nt = 0;
end
x = mean(XCBO);
disp('Xmean');
disp(mean(x));
disp('XCoV');
disp(sqrt(var(XCBO))/mean(x));
disp('cost');
disp(mean(ccbo));
disp('Pf');
disp(mean(pf));
disp('Ng');
disp(mean(ngcbo));
disp('CoVNg');
disp(sqrt(var(ngcbo))/mean(ngcbo));



