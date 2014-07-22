close all; clc; clear all;

load Provete_69_base_1.mat; sup1 = Z; parte1 = Parte;
load Provete_69_topo_1.mat; sup2 = Z; parte2 = Parte; clear Z;

%% Roda e inverte topo (se for preciso)
% Se estiver a acertar base com topo, parte1 é dif. de parte2,
% logo rodamos o topo (parte2) duas vezes para poder sobrepor à base
% Se estiver a  acertar duas digitalizações da mesma superficie não é
% preciso fazer isto, mas o primeiro IF faz saltar à frente
if ~strcmp(parte1,parte2)           % Um é base e o outro é topo        
    sup2 = flipud(sup2);            % Roda o topo
    media = mean(mean(sup2));       % Média dos elementos do topo
    for i = 1:size(sup2,1)          
        for j = 1:size(sup2,2)
            sup2(i,j) = -sup2(i,j) + 2*media ; % Troca picos por vales e vice-versa
        end
    end
end
%% Calcula o erro para uma distribuição de valores dx e dy
 % Ajuste de di e dj - Corta partes das superficies de cima e 
    %de baixo para que tenham o mesmo tamanho e não fique nada de fora
    % Apaga colunas e linhas da base onde topo esta vazio 
for delta_i = 0:30;
    for delta_j = 0:30;
        [ sup1_crop sup2_crop ] = cropa_surfs( sup1, sup2, delta_i, delta_j);
        [erro_dxdy(delta_i+1,delta_j+1)] = erro_surfs(sup1_crop,sup2_crop) ;
    end
end

   % surf(erro_dxdy)

% Encontra i,j mínimos de erro (o valor do erro em si não interessa)
erro_min = min(min(erro_dxdy));
[i_min j_min ] = find(erro_dxdy == erro_min); 
[ sup1_crop sup2_crop ] = cropa_surfs( sup1, sup2, i_min, j_min);
[erro_min ] = erro_surfs(sup1_crop,sup2_crop) ;
%% Encontra dz que minimiza o erro
dz = -5:0.1:5;
for i=1:size(dz,2)
    sup2_crop_dz = sup2_crop + dz(i);
    [erro_dz(i) ] = erro_surfs(sup1_crop,sup2_crop_dz) ;
end
erro_min = min(min(erro_dz));
[i_dz] = find(erro_dz == erro_min); 

%Faz sup final
sup2_crop_dz = sup2_crop + dz(i_dz);
%% Encontra rotaçao em torno do eixo y que minimiza o erro
pos_eixo_j = 0 : 2 :size(sup2,2);
teta_j = -.5  : .1 : .5;

sup2_crop_dz_roty = zeros(size(sup2_crop_dz)); erro_roty = zeros(size(pos_eixo_j,1),size(teta_j,1));

for pos = 1 : size(pos_eixo_j,2)
    for ang = 1 : size(teta_j,2)
            for j = 1 : size(sup2_crop_dz,2)
                sup2_crop_dz_roty(:,j) = sup2_crop_dz(:,j) + ...
                    (j - pos_eixo_j(pos)) * freq_amostragem  * tan(teta_j(ang)*pi/180) ;
            end
           [erro_roty(pos,ang)] = erro_surfs(sup1_crop,sup2_crop_dz_roty);
    end
end


erro_min_roty = min(min(erro_roty));
[i_min j_min ] = find(erro_roty == erro_min_roty);
eixo_j_opt = pos_eixo_j(i_min);
teta_j_opt = teta_j(j_min);


% surf(erro_roty)
% ylabel('posiçao do eixo'); xlabel('angulo')


for j = 1 : size(sup2_crop_dz,2)
    sup2_crop_dz_roty(:,j) = sup2_crop_dz(:,j) + ...
        (j - eixo_j_opt(1)) * freq_amostragem * tan(teta_j_opt(1)*pi/180) ;
end

%surf(sup1_crop-sup2_crop_dz_roty)
%% Encontra rotaçao em torno do eixo x que minimiza o erro
pos_eixo_i = 0 : 2 :size(sup2,1);
teta_i = -.5  : .1 : .5;

sup2_crop_dz_roty_rotx = zeros(size(sup2_crop_dz_roty)); 
erro_roty_rotx = zeros(size(pos_eixo_i,1),size(teta_i,1));

for pos = 1 : size(pos_eixo_i,2)
    for ang = 1 : size(teta_i,2)
            for i = 1 : size(sup2_crop_dz_roty,1)
                sup2_crop_dz_roty_rotx(i,:) = sup2_crop_dz_roty(i,:) + ...
                    (i - pos_eixo_i(pos)) * freq_amostragem  * tan(teta_i(ang)*pi/180) ;
            end
           [erro_rotx(pos,ang)] = erro_surfs(sup1_crop,sup2_crop_dz_roty_rotx);
    end
end


erro_min_rotx = min(min(erro_rotx));
[i_min j_min ] = find(erro_rotx == erro_min_rotx);
eixo_i_opt = pos_eixo_i(i_min)
teta_i_opt = teta_i(j_min)


%surf(erro_rotx)
%ylabel('posiçao do eixo'); xlabel('angulo')


for i = 1 : size(sup2_crop_dz_roty_rotx,1)
    sup2_crop_dz_roty_rotx(i,:) = sup2_crop_dz_roty(i,:) + ...
        (i - eixo_i_opt(1)) * freq_amostragem * tan(teta_i_opt(1)*pi/180) ;
end

erro_surfs(sup1_crop,sup2_crop)
erro_surfs(sup1_crop,sup2_crop_dz)
erro_surfs(sup1_crop,sup2_crop_dz_roty)
erro_surfs(sup1_crop,sup2_crop_dz_roty_rotx)
%% Salva parte de baixo e de cima ajustadas
base_mated = sup1_crop; topo_mated = sup2_crop_dz_roty_rotx;

nome = strcat('Provete_' , Numero  , '_'  , Iteracao , '_mated.mat')
save(nome, 'base_mated','topo_mated')