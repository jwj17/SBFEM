%A RockFillDam
close all; clearvars; dbstop error;

% handler of problem definition function
probdef = @ProbDefFace;

%% Mesh generation
mesher = 1; % = 1: DistMesh; = 3: pre-stored triangular mesh
para.h0 = 0.05; % element size when using DistMesh
[ coord, sdConn, sdSC ] = createSBFEMesh(probdef, mesher, para);

figure;
PlotSBFEMesh(coord, sdConn);
title('MESH');

% %% static analysis (RockFill)
% slnOpt.type='STATICS'; % 'STATICS'; 'MODAL'; 'TIME';
% [U] = SBFEPoly2NSolver(probdef, coord, sdConn, sdSC, slnOpt);