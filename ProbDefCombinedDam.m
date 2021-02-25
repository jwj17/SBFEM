function [x] = ProbDefCombinedDam(Demand,Arg)
%Combine face with rockfill

switch(Demand)
    case('Domains');   x = definitionOfDomains();
    case('MAT');       x = definitionOfMaterials();
    case('BCond');     x = BoundaryCond(Arg);
    case('Output');    x = [];
    case('EXACT');     x = [];
end
end

function [x] = definitionOfDomains()
prodef = {@ProbDefRockFill, @ProbDefFace};
cshft = [3 0; 0 0]; 
onLine = {@(xy, eps) find(abs(xy(:,2)-0.5*xy(:,1)+1.5) < eps)};
% change intercept here
x = struct('prodef',{prodef}, 'cshft', cshft, 'onLine',{onLine});
end

function [x] = definitionOfMaterials()
x = {ProbDefRockFill('MAT'); ProbDefFace('MAT')};
end

function [x] = BoundaryCond(Arg)
coord = Arg{1};
sdConn = Arg{2};

eps = 1e-4*(max(coord(:,1))-min(coord(:,1)));
bNodes = find(abs(coord(:,2)-min(coord(:,2)))<eps);
BC_Disp = [ [bNodes; bNodes ], [ones(length(bNodes),1);...
   2*ones(length(bNodes),1)], zeros(2*length(bNodes),1) ];

[ MeshEdges ] = meshConnectivity( sdConn );
centres = (coord(MeshEdges(:,1),:)+coord(MeshEdges(:,2),:))/2;
% the lean face of dam
lEdges = MeshEdges(centres(:,2)-0.5*centres(:,1)<eps,:);
ymax = max(coord(:,2));
% tEdges = MeshEdges((abs(coord(MeshEdges(:,1),2)-ymax)+...
%     abs(coord(MeshEdges(:,2),2)-ymax))<eps,:);

F = zeros(2*size(coord,1),1);
dir = [1/sqrt(5); -2/sqrt(5); 1/sqrt(5); -2/sqrt(5)];
% prescribed water pressure
pressure = [10*(ymax-coord(lEdges(:,1),2))';10*(ymax-coord(lEdges(:,2),2))'];
    
trac = [dir(1)*pressure(1,:);dir(2)*pressure(1,:);...
    dir(3)*pressure(2,:);dir(4)*pressure(2,:)];
F = addSurfTraction(coord, lEdges, trac, F);

x = {BC_Disp, F};
end



