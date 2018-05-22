clc;
clear all;
close all;
index=1;


count = 0;

% Number of underwater sensor nodes
numNodes = 125;

% Acoustic communication range of sensor
accRange=250;

% Packet reached sink
succ=zeros(numNodes,1);

%Max Prop delay
delay = 0.2;
% Sink Co-ordinates, sink present in water surface so z co-ordinate is 0.
sink(1,1)=500 ;
sink(1,2) = 500;
sink(1,3) = 1000;

n=1;

% Min range of x,y,z
min_x=0;
min_y=0;
min_z=0;

% Min range of x,y,z
max_x=1000;
max_y=1000;
max_z=1000;

root= nthroot(numNodes,3);
x= floor(root);
y= floor(root);
z= floor(root);

m= x*y*z;

x_segment=max_x/x;
y_segment=max_y/y;
z_segment=max_z/z;


nodePositions= zeros(m,3);

for i=0 :x_segment: (max_x-1)
      for j=0 :y_segment: (max_y-1)
        for k=0:z_segment: (max_z-1)
           
           
             nodePositions(n,1) = (rand) * (x_segment)+i
             nodePositions(n,2) = (rand) * (y_segment)+j
             nodePositions(n,3) = (rand) * (z_segment)+k
             n= n+1;
          
         end
      end         
end
  
% Plot the nodes and sink in 3-D

plot3(nodePositions(:, 1), nodePositions(:, 2),nodePositions(:, 3), '+', ...
    'MarkerSize',15);
hold on
plot3(sink(1, 1), sink(1, 2),sink(1, 3), 'S', 'MarkerFaceColor', 'g');


for i=1:125
    forwarder=i
% Untill reach destination
while ( succ(i) == 0)
    
%find the neighbour nodes from forwarder
[neighbours ,succ]  = find_neighbours(i,forwarder,sink,accRange,numNodes,nodePositions, succ);

if(succ(i,1) == 1)
    %disp('---> sink');
    %delay= delay +0.2
    
    %disp('packet routed succesfully');
    %disp(delay);
    count =count +1;
     continue;
   % return;
   %succ=0;
end
    
% find total number of neighbours
totalNeighbours=numel(neighbours);
if(totalNeighbours==0)
    disp('NO NEIGHBOURS');
    %return;
    continue;
end
[min_hop, void ] = find_next_hop(forwarder,sink, neighbours, nodePositions);
list_of_nodes(index)=min_hop;
index = index +1;
forwarder=min_hop;
delay = delay + 0.2;

if (void==1)
    % disp('FOUND VOID NODE: GREEDY FORWARDING TERMINATED');
   void =void +1;
     %return;
end

end

end
fprintf('number of non-voidnodes are %d .\n',count);

