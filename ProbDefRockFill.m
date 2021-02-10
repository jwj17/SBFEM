function [x] = ProbDefRockFill(Demand,Arg)
%Problem definiton fucction of the RockFill
%inputs
%    Demand  - option to access data in local functions
%    Arg     - argument to pass to local functions
%output
%    x       - cell array of output.

para = struct('L',2, 'H',1, 'E', 10E6, 'pos',0.2, 'den',2);
BdBox = [0 2*para.L 0 para.H para.L];
switch(Demand)
    case('TriMesh');x = TriMesh;
    %PolyMesher
    case('Dist'); x = DistFnc(Arg,BdBox);
    case('BC'); x = {[],[]};
    %DistMesh
    case('Dist_DistMesh'); x = DistFnc(Arg,BdBox);
        x = x(:,end);
    case('fh'); x = huniform(Arg);
    case('pfix'); x = [BdBox([1 3]); BdBox([2 3]); BdBox([5 4])];
    %for DistMesh and PolyMesher
    case('BdBox'); x = BdBox;
    
    case('MAT'); x = struct('D', IsoElasMtrx(para.E, para.pos), 'den', para.den);
end
end

function Dist = DistFnc(P, BdBox)
Dist = dpoly(P,[BdBox([1 3]); BdBox([2 3]); BdBox([5 4]); BdBox([1 3])]);
end

