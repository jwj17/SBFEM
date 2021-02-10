%A RockFillDam(Combined)
close all; clearvars; dbstop error;

% handler of problem definition function
probdef = @ProbDefCombinedDam;

%% Mesh generation
para = {struct('mesher',1, 'h0', 0.2, 'material', 1), struct('mesher',1, 'h0', 0.1, 'material', 2)};
dDefs = probdef('Domains');
[ coord, sdConn, sdSC, sdMat ] = createMultiDomainMesh(dDefs, para);

figure;
opt = struct('sdSC', sdSC, 'PlotNode',1, 'MarkerSize',2);
PlotSBFEMesh(coord, sdConn);
title('MESH');

%% static analysis (RockFill)
slnOpt.type='STATICS'; % 'STATICS'; 'MODAL'; 'TIME';
[U] = SBFEPoly2NSolver(probdef, coord, sdConn, sdSC, slnOpt, sdMat);