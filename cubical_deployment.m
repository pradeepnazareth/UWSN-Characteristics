clc;
clear all;
close all;

%Number of nodes---CAN BE CHANGED
numNodes=2;

i=1;
%Sink node position --CAN BE CHANGED
sink(1,1)=500 ;
sink(1,2)=500 ;
sink(1,3)=0 ;


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
accRange=200;
% 3-D positions of node
nodePositions= zeros(numNodes,3);

% Node deployment area
max_x=1000;
max_y=1000;
max_z=1000;

%Initial deployment with planned deployment
    for x=(accRange/2):accRange:max_x
        for y=(accRange/2):accRange:max_y
            for z=(accRange/2):accRange:max_z
                if (i <= numNodes)
                nodePositions(i,1)=x;
                nodePositions(i,2)=y;
                nodePositions(i,3)=z;
                i=i+1;
                end
             end
        end
    end
    
%List of neighbours for a node
neighbour=zeros(numNodes,numNodes);
void_nodes=  zeros(numNodes,1);

 for i=1:numNodes
       
 [neighbour, neighbour_to_sink_dis, void_nodes,  dst ]= find_void(i,sink,numNodes,nodePositions,...
     accRange, neighbour, void_nodes,neighbour_to_sink_dis, dst);
     
 end
 

   
% End of while 
% Plot the nodes and sink in 3-D
plot3(nodePositions(:, 1), nodePositions(:, 2),nodePositions(:, 3), '+', ...
    'MarkerSize',15);
hold on
plot3(sink(1, 1), sink(1, 2),sink(1, 3), 'S', 'MarkerFaceColor', 'g');

