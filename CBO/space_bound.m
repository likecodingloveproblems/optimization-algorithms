% GSA code v1.1.
% Generated by Esmat Rashedi, 2010. 
% " E. Rashedi, H. Nezamabadi-pour and S. Saryazdi,
%�GSA: A Gravitational Search Algorithm�, Information sciences, vol. 179,
%no. 13, pp. 2232-2248, 2009."
%
%This function checks the search space boundaries for agents.
function  X=space_bound(X,up,low)

[N,dim]=size(X);
for i=1:N 
%     %%Agents that go out of the search space, are reinitialized randomly .
   Tp=X(i,:)>up;Tm=X(i,:)<low;X(i,:)=(X(i,:).*(~(Tp+Tm)))+((rand(1,dim).*(up-low)+low).*(Tp+Tm));
%     %%Agents that go out of the search space, are returned to the boundaries.
         %Tp=X(i,:)>up;Tm=X(i,:)<low;X(i,:)=(X(i,:).*(~(Tp+Tm)))+up.*Tp+low.*Tm;

end
