function z = cost(x)
b = x(1);
l = x(2);
d = x(3);
h = 0.6;
%unit cost
ce=25.16;
cf=51.97;
cr=2.16;
cc=173.96;
cb=3.97;

%work volume
b0=0.3;
l0=0.3;
qe=(b+b0)*(l+l0)*d;
qf=2*h*(b+l);
qc=b*l*h;
k=29.67;
qr=k*qc;
qb=qe-qc;

cfail = 1e2;
z=qe*ce+qf*cf+qc*cc+qr*cr+qb*cb+cfail*cons(x);
end