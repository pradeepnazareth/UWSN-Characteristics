clc;
clear all;
close all;
index=1;

% Number of underwater sensor nodes
numNodes = 100;
% Acoustic communication range of sensor
accRange=50;
% Packet reached sink
succ = 0;
%Max Prop delay
delay = 0;
% Sink Co-ordinates, sink present in water surface so z co-ordinate is 0.
sink(1,1)=50 ;
sink(1,2) = 50;
sink(1,3) = 0;

% Min range of x,y,z
min_x=0;
min_y=0;
min_z=0;

% Min range of x,y,z
max_x=100;
max_y=100;
max_z=-300;

nodePositions = zeros(numNodes,3);

% Randomly deploy nodes

for i=1:numNodes
    nodePositions(i,1) = (rand) * (max_x);
    nodePositions(i,2) = (rand) * (max_y);
    nodePositions(i,3) = (rand) * (max_z);
end

% Create 3 additional nodes which are acts as source
%their depth is -100 and x /y co-ordinates generated randomly
%s1=numNodes+1;
%s2=numNodes+2;
%s3=numNodes+3;
%nodePositions(s1,3) = -100;
%nodePositions(s2,3)= -100;
%nodePositions(s3,3) = -100;

%for i= (numNodes+1): (numNodes+3)
%    nodePositions(i,1) = (rand) * (max_x);
  %  nodePositions(i,2) = (rand) * (max_y);
%end

source=input('Please enter the source node  = ');
forwarder=source;
% Plot 3-D of all nodes
plot3(nodePositions(:, 1), nodePositions(:, 2),nodePositions(:, 3), '+', ...
    'MarkerSize',15);
hold on
plot3(sink(1, 1), sink(1, 2),sink(1, 3), 'S', 'MarkerFaceColor', 'g');

% Untill reach destination


while ( succ == 0)
%find the neighbour nodes from forwarder
[neighbours ,succ]  = find_neighbours(forwarder,sink,accRange,numNodes,nodePositions);
if(succ == 1)
    delay= delay +0.2
    disp('---> sink');
    disp('packet routed succesfully');
    disp(delay);
    return;
end
    
% find total number of neighbours
totalNeighbours=numel(neighbours);
if(totalNeighbours==0)
    disp('NO NEIGHBOURS');
    return;
end
[min_hop, void ] = find_next_hop(forwarder,sink, neighbours, nodePositions);
list_of_nodes(index)=min_hop;
index = index +1;
forwarder=min_hop;
delay = delay + 0.2;

if (void==1)
     disp('FOUND VOID NODE: GREEDY FORWARDING TERMINATED');
    return;
end

end


