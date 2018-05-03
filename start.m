clc;
close all;

% Number of underwater sensor nodes
numNodes = 100;
% Acoustic communication range of sensor
accRange=50;
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
max_z=-100;

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

n1=input('Please enter the source node = ');
% Plot 3-D of all nodes
plot3(nodePositions(:, 1), nodePositions(:, 2),nodePositions(:, 3), '+', ...
    'MarkerSize',15);
hold on
plot3(sink(1, 1), sink(1, 2),sink(1, 3), 'S', 'MarkerFaceColor', 'g');


%find the neighbour node from source
neigh = find_neighbours(n1,accRange, numNodes,nodePositions);

% find total number of neighbours
totalNeighbours=numel(neigh);

%list_of_nodes=find_next_hops(n1, nodePositions);



