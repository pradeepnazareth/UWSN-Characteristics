clc;
clear all;
close all;

%Number of nodes---CAN BE CHANGED
numNodes= 100;

%Sink node position --CAN BE CHANGED
sink(1,1)=500 ;
sink(1,2)=500 ;
sink(1,3)=1000 ;

% Flag to ensure that at the end of deployment/redeployment, NO VOID NODES
% ARE EXIST-- DON'T CHANGE
flag=1;

% Distance between neighbours of a node to sink --Used in finding void
% nodes
neighbour_to_sink_dis= zeros(numNodes,numNodes);

%Total void nodes, After complete deployment
void_count=0;

% distance between node to sink & min. distance between a neighbour to sink
dst=zeros(numNodes,2);

%List contains, void nodes
voids=[];
indx=1;

%Communication Range of sesor nodes
accRange=250;
% 3-D positions of node
nodePositions= zeros(numNodes,3);

% Node deployment area
max_x=1000;
max_y=1000;
max_z=1000;

%Initial deployment
for i=1:numNodes
    nodePositions(i,1)= rand * max_x;
    nodePositions(i,2)= rand * max_y;
    nodePositions(i,3)= rand * max_z;
end
  
% Plot the nodes and sink in 3-D
plot3(nodePositions(:, 1), nodePositions(:, 2),nodePositions(:, 3), '+', ...
    'MarkerSize',15);
hold on
plot3(sink(1, 1), sink(1, 2),sink(1, 3), 'S', 'MarkerFaceColor', 'g');

%List of neighbours for a node
neighbour=zeros(numNodes,numNodes);
void_nodes=  zeros(numNodes,1);

 for i=1:numNodes
       
 [neighbour, neighbour_to_sink_dis, void_nodes,  dst ]= find_void(i,sink,numNodes,nodePositions,...
     accRange, neighbour, void_nodes,neighbour_to_sink_dis, dst);
     
 end
 
 % Put void nodes in a list  and Count total void nodes after initial
 % deployment

 for i=1:numNodes
     if(void_nodes(i,1)==1)
     void_count= void_count +1;
     voids(indx)=i;
     indx = indx +1;
     end
 end
 
 % Code for De-deployment of void nodes  
while (flag == 1)
    for i=1:void_count     
        while (void_nodes(voids(i),1)==1)
            nodePositions(voids(i),1)= rand * max_x;
            nodePositions(voids(i),2)= rand * max_y;
            nodePositions(voids(i),3)= rand * max_z;
            [neighbour, neighbour_to_sink_dis, void_nodes, dst ]= find_void(voids(i),sink,numNodes,nodePositions,...
            accRange, neighbour, void_nodes,neighbour_to_sink_dis, dst);
        end % End of while 
    end % End of for 
 
    void_count=0;
    voids = [];
    indx=1;
    % check for all nodes whether void or not, after redeployment
    for i=1:numNodes
        [neighbour, neighbour_to_sink_dis, void_nodes,  dst ]= find_void(i,sink,numNodes,nodePositions,...
        accRange, neighbour, void_nodes,neighbour_to_sink_dis, dst);
    end % End of for 
 
    for i=1:numNodes
        if(void_nodes(i,1)==1)
        void_count= void_count +1;
        voids(indx)=i;
        indx = indx +1;
        end % End of if
    end %End of for
 
    if ( void_count > 0)
        flag=1;
    else
        flag=0;
    end % End of if
   
end % End of while 
 
     
    
% Untill reach destination
%while ( succ(i) == 0)
    
%find the neighbour nodes from forwarder
%[neighbours ,succ]  = find_neighbours(i,forwarder,sink,accRange,numNodes,nodePositions, succ);

%if(succ(i,1) == 1)
  %    count =count +1;
 %     continue;
   % return;
   %succ=0;
%end
    
% find total number of neighbours
%totalNeighbours=numel(neighbours);
%if(totalNeighbours==0)
 %   disp('NO NEIGHBOURS');
    %return;
  %  continue;
%end
%[min_hop, void ] = find_next_hop(forwarder,sink, neighbours, nodePositions);
%list_of_nodes(index)=min_hop;
%index = index +1;
%forwarder=min_hop;
%delay = delay + 0.2;

%if (void==1)
    % disp('FOUND VOID NODE: GREEDY FORWARDING TERMINATED');
 %  void =void +1;
     %return;
%end

%end

%end
%fprintf('number of non-voidnodes are %d .\n',count);
% }
