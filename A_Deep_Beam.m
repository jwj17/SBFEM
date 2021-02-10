%A deep beam
close all; clearvars; dbstop error;

% handler of problem definition function
probdef = @ProbDefDeepBeam;

%% Mesh generation
mesher = 1; % = 1: DistMesh; = 3: pre-stored triangular mesh
para.h0 = 0.1; % element size when using DistMesh
[ coord, sdConn, sdSC ] = createSBFEMesh(probdef, mesher, para);

figure;
PlotSBFEMesh(coord, sdConn);
title('MESH');

%% static analysis (pure bending)
slnOpt.type='STATICS'; % 'STATICS'; 'MODAL'; 'TIME';
[U] = SBFEPoly2NSolver(probdef, coord, sdConn, sdSC, slnOpt);

% %% modal analysis (cantilever beam)
% slnOpt.type='MODAL';
% slnOpt.modalPara = 4;
% [f] = SBFEPoly2NSolver(probdef, coord, sdConn, sdSC, slnOpt);
% 
% %% response history analysis (cantilever beam)
% slnOpt.type='TIME';
% slnOpt.TIMEPara = [500 0.0002];
% [t, dsp] = SBFEPoly2NSolver(probdef, coord, sdConn, sdSC, slnOpt);
% 
