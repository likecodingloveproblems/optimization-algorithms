function s = cons(x)
B = x(1);
L = x(2);
D = x(3);
E = 50;
v = 0.3;
phi = 35;
F = 3000;
gama = 18.5;
phi=180/pi*phi; %make phi by degree
%F.S
nq=(exp(pi*tan(phi)))*(tan(pi/4+phi/2))^2;
ng=2*(nq+1)*tan(phi);
ngs=1-0.4*B/L;
ngd=1;
nqs=1+(B/L)*tan(phi);
nqd=1+2*tan(phi)*((1-sin(phi))^2)*(pi/180*atan(D/B));
q = F/(B*L);

qult=0.5*B*gama*ng*ngs*ngd+q*nq*nqs*nqd;


%Settlement

bz=-0.0017*(L/B)^2+0.0597*(L/B)+0.9843;
delta=F*(1-v^2)/(bz*E*sqrt(B*L));

%objective function

s = max([3-qult*B*L/F;
      delta-25;
      D-2;
      0.5-D;
      0]);
  
end