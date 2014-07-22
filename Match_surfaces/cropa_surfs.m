function [ sup1 sup2 ] = cropa_surfs( sup1, sup2, delta_i, delta_j)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    dim_sup1 = size(sup1); % Dimensao da base
    dim_sup2 = size(sup2); % Dimensao do topo (normalmente é menor que a base)

    % Apaga final e inicio do no eixo x - i
    sup1(:,delta_i + dim_sup2(2)+1:end) = []; 
    sup1(:,1:delta_i ) = [];
%
    sup1(delta_j + dim_sup2(1)+1:end,:) = []; % Apaga final no eixo y
    sup1(1:delta_j,:) = []; % Apaga inicio no eixo y
% Tamanho final de sup1, que vai ter de ser tb o tamanho final de sup2 
    dim_sup1 = size(sup1);
    %
    sup2(:,dim_sup1(2)+1:end) = []; % Apaga fim do eixo x
    sup2(dim_sup1(1)+1:end,:) = []; % Apaga fim do eixo y
end