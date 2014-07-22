close all;clear all;clc;
load Provete_69_Base_1
vec_Z_base = Z(:); clear Z
load Provete_69_Topo_1
vec_Z_topo = Z(:);

% Que análise vamos fazer?
% DUVIDA - Devemos usar as superficies mated em cima e em baixo (cortar
% a de baixo) para podermos comparar uma e outra e ver se o ajuste é bom. 

% Faz mais sentido as superficies terem mínimo ZERO ou Média Zero?
vec_Z(:,1) = vec_Z_base(1:25000); 
vec_Z(:,2) = vec_Z_topo(1:25000);

x=0:0.5:12;

figure
hist(vec_Z,x)


return

close all;clear all;clc;
load('Provetecomquadro_69_Topo_1')

dim_Z=size(Z);
vetor=dim_Z(1,1)*dim_Z(1,2);
max_Z=max(max(Z));
min_Z=min(min(Z));


