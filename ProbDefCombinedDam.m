function [x] = ProbDefCombinedDam(Demand,Arg)
%Combine face with rockfill

switch(Demand)
    case('Domains'); x = definitionOfDomains();
    case('MAT'); x = definitionOfMaterials();

end
end

function [x] = definitionOfDomains()
prodef = {@ProbDefRockFill, @ProbDefFace};
cshft = [0.3 0; 0 0]; 
onLine = {@(xy, eps) find(abs(xy(:,2)-0.5*xy(:,1)+0.15) < eps)};
x = struct('prodef',{prodef}, 'cshft', cshft, 'onLine',{onLine});
end

function [x] = definitionOfMaterials()
x = {ProbDefRockFill('MAT'); ProbDefFace('MAT')};
end


