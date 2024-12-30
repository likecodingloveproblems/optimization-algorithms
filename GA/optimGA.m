clc
global nt
nt = 0;
disp('-------------------------------------------------')
disp('-------------------------------------------------')
disp('GA')
XGA = [];
c = [];
ngga = [];
noga = [];
pf = [];
for i = 1:1
[xga, fvalga, exitflagga,outputga] = GA();
XGA = [XGA xga];
ngga = [ngga; nt];
c = [c cost(xga)];
noga = [noga ; outputga.funccount];
nt = 0;
end
nt = 0;
x = mean(XGA);
disp('Xmean');
disp(mean(x));
disp('XCoV');
disp(sqrt(var(XGA))/mean(x));
disp('cost');
disp(mean(c));
disp('Pf');
disp(mean(pf));
disp('No');
disp(mean(noga));
disp('Ng');
disp(mean(ngga));
disp('CoVNg');
disp(sqrt(var(ngga))/mean(ngga));

