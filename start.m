clc;
clear all;
close all;
void = zeros(10,3);
for t=1:10
   
    
% Number of underwater sensor nodes
numNodes = t*t *t;
void(t,1)=numNodes;
dst=zeros(numNodes,2);
% Acoustic communication range of sensor
accRange=250;

% To keep track of void nodes
void_nodes = zeros(numNodes,1);

%Count void node
void_count = 0;

neighbour_to_sink_dis= zeros(numNodes,numNodes)

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

m=x*y*z;

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

neighbour=zeros(numNodes,numNodes);
void_nodes=  zeros(numNodes);

 for i=1:numNodes
       
 [neighbour, neighbour_to_sink_dis, void_nodes, void_count, dst ]= find_void(i,sink,numNodes,nodePositions,...
     accRange, neighbour, void_nodes,neighbour_to_sink_dis, void_count, dst);
     
 end
 void(t,2)= void_count;
 void(t,3)=void(t,2)/void(t,1);
end

figure;
t=1:1:10;
plot(void(t,1),void(t,3),'m');
grid on;
xlabel('Number of nodes')
ylabel('Fraction of void nodes')   



    
    
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
