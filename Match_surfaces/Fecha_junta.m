clear all; close all; clc;
load Provete_69_2_mated.mat
freq_amostragem = 0.5 ;
dim_i = size(topo_mated,1);
dim_j = size(topo_mated,2);
media = mean(mean(topo_mated));       % Média dos elementos do topo
%% Como a matriz de cima está ajustada com a de baixo, volta a tornar os
% vales em picos e vice-versa
for i = 1:dim_i
    for j = 1:dim_j
        topo_mated(i,j) = +topo_mated(i,j) - 2*media ; % Troca picos por vales e vice-versa
    end
end
clear media
%% Levanta o topo até que ele deixa de tocar na base

penetracao = zeros(dim_i,dim_j);
dz = 11:.05:14;
entrei = 0;
area_comum = dz.*0;
for h = 1:size(dz,2)
    topo_mated_elevado = topo_mated + dz(h);
    for i = 1:dim_i
        for j = 1:dim_j
            penetracao(i,j) = base_mated(i,j) - topo_mated_elevado(i,j);
            if  penetracao(i,j) > 0
                area_comum(h) = area_comum(h) + 1*freq_amostragem.^2;
            end
        end
    end
    if  (area_comum(h) == 0 ) 
        if entrei ~= 1
            dz_toca = dz(h);
            area_toca = area_comum(h);
            topo_mated_toca = topo_mated_elevado;
            penetracao_toca = penetracao;
            entrei = 1;
        end
    end
end
clear entrei h i j area_toca ...
    penetracao_toca 
%%
dz = -dz + dz_toca
%%
plot(dz,area_comum,'-o')
axis([0 .5 0 100])
xlabel('Joint closure[mm]'); ylabel('Contacto area [mm^]');
