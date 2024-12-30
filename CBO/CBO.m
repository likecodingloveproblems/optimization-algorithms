function [ bestCost, bestDesign,Convergence_curve] = CBO(popSize,maxIt,xMin,xMax,nVar,eval)
% Colliding Bodies Optimization - CBO
% clear memory 
%clear all   
% Initializing variables 
%popSize=10;     % Size of the population 
%nVar=2;        % number of optimization variables 
%xMin=0;      % lower bound of the variables 
%xMax=1;       % upper bound of the variables 
%maxIt=200;      % Maximum number of iteration   
Convergence_curve=zeros(1,maxIt);
CB=zeros(popSize,nVar);
% Initializing Colliding Bodies (CB) 
for i = 1:popSize
CB(i,:)=xMin+rand(1,nVar).*(xMax-xMin);% random population 
end

%eval = @cost;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% Start iteration 
iter=0;                     % counter 
Inf=1e100;                  % infinity 
bestCost=Inf;               % initializing the best cost 
agentCost=zeros(popSize,2); % array of agent costs   

while iter < maxIt     
    iter=iter+1;  
    
    % Evaluating the population     
     CB=space_bound(CB,xMax,xMin); 
    for e=1:popSize    
        Cost=eval(CB(e,:)); % evaluating objective function for each agent         
        agentCost(e,1)=Cost;        
        agentCost(e,2)=e;     
    end
    % Finding the best CB     
    agentCost=sortrows(agentCost);     
    if agentCost(1,1)<bestCost         
        bestCost=agentCost(1,1);         
        bestDesign=CB(agentCost(1,2),:); 
        % the best design     
    end
    % Evaluating the mass     
    mass=zeros(popSize,1);     
    for e=1:popSize         
        mass(e,:)=1/(agentCost(e,1));     
    end
    % Updating CB positions     
    for e=1:popSize/2         
        indexS=e;      
        % index of stationary bodies         
        indexM=popSize/2+e; 
        % index of moving bodies         
        COR=(1-(iter/maxIt)); 
        % coefficient of restitution         
        % velocity of moving bodies before collision     
        velMb=(CB(agentCost(indexS,2),:)-CB(agentCost(indexM,2),:));         
        % velocity of stationary bodies after collision 
        velSa=((1+COR)*mass(indexM,1))/(mass(indexS,1)+mass(indexM,1))*velMb;         
        % velocity of moving bodies after collision   
        velMa=(mass(indexM,1)-COR*mass(indexS,1))/(mass(indexS,1)...        
        +mass(indexM,1))*velMb;          
        CB(agentCost(indexM,2),:)=CB(agentCost(indexS,2),:)...    
        +2*(0.5-rand(1,nVar)).*velMa;         
        CB(agentCost(indexS,2),:)=CB(agentCost(indexS,2),:)...
        +2*(0.5-rand(1,nVar)).*velSa; 
    end 
    Convergence_curve(iter)=bestCost;

end% while
 
%disp(bestCost) 
%disp(bestDesign) 
end
