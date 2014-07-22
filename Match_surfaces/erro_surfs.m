function [erro] = erro_surfs( sup1 , sup2 )
%MATCH_SURF_FUNC_OBJECTIVO Summary of this function goes here
%  Funçao calcula diferença etre duas superfícies 
erro = 0;
for i = 1:size(sup1,1)
    for j = 1 : size(sup1,2)
        erro = erro + (( sup1(i,j) - sup2(i,j) )^2)^0.5;
    end
end
%
% Faz correcção do erro com a área considerada
erro =  erro / (size(sup1,1) * size(sup1,2) ); %
end