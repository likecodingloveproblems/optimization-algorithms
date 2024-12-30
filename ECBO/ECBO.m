function [bestCost,bestDesign,Convergence_curve] = ECBO(popSize,maxIt,xMin,xMax,nVar,eval)
% Enhanced Colliding Bodies Optimization - ECBO
% clear memory 
%clear all   
% Initializing variables 
%popSize=10;     % Size of the population 
%nVar=2;        % number of optimization variables 
cMs=2;          % Colliding memory size 
pro=0.3; 
%xMin=0;      % lower bound of the variables 
%xMax=1;       % upper bound of the variables 
%maxIt=200;      % Maximum number of iteration   

% Initializing Colliding Bodies (CB) 
for i = 1:nVar
CB(:,i)=xMin(i)+rand(popSize,1).*(xMax(i)-xMin(i));% random population 
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% Start iteration 
iter=0;                     % counter 
agentCost=zeros(popSize,2); % array of agent costs 
Inf=1e100;                  % infinity 
% Colliding memory; The first column contains CB costs and the remaining columns include CB positions 
cm=zeros(cMs,nVar+1); 
tm=zeros(2*cMs,nVar+1);     % Temporary memory 
for e=1:cMs     
    cm(e,1)=Inf; 
end
Convergence_curve=zeros(1,maxIt);
while iter < maxIt     
    iter=iter+1;          
    CB=space_bound(CB,xMax,xMin); 
    % Evaluating the population     
    for e=1:popSize         
        Cost=eval(CB(e,:)); % evaluating objective function for each agent         
        agentCost(e,1)=Cost;         
        agentCost(e,2)=e;     
    end
    % Updating colliding memory     
    agentCost=sortrows(agentCost);     
    if  iter>1         
        for e=1:cMs             
            agentCost(popSize-cMs+e,1)=cm(e,1);             
            for ee=1:nVar                 
                CB(agentCost(popSize-cMs+e,2),ee)=cm(e,ee+1);             
            end
        end
    end
    for e=1:cMs         
        tm(e,1)=agentCost(e,1);         
        tm(e+cMs,1)=cm(e,1);         
        for ee=1:nVar             
            tm(e,ee+1)=CB(agentCost(e,2),ee);             
            tm(e+cMs,ee+1)=cm(e,ee+1);
        end
    end
    tm=sortrows(tm);     
    for e=1:cMs         
        cm(e,:)=tm(e,:);     
    end
    agentCost=sortrows(agentCost);          
    
    % Evaluating the mass     
    mass=zeros(popSize,1);     
    for e=1:popSize         
        mass(e,:)=1/(agentCost(e,1));     
    end
    
    % Updating CB positions     
    for e=1:popSize/2         
        indexS=e;      % index of stationary bodies         ['['
        indexM=popSize/2+e;   % index of moving bodies         
        COR=(1-(iter/maxIt)); % coefficient of restitution         
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
        if rand<pro             
            tmp=ceil(rand*nVar);             
            CB(agentCost(indexS,2),tmp)=xMin(tmp)+rand*(xMax(tmp)-xMin(tmp));         
        end
        if rand<pro             
            tmp=ceil(rand*nVar);             
            CB(agentCost(indexM,2),tmp)=xMin(tmp)+rand*(xMax(tmp)-xMin(tmp));         
        end
    end
Convergence_curve(iter)=cm(1,1);
end % while

% disp(cm(1,:))
bestCost = cm(1,1);
bestDesign = cm(1,2:nVar+1);
end