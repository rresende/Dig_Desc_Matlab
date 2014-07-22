clc % Limpa ecrã
clear all% Limpa variaveis
close all % Fecha janelas 
%
% Limites de corte dos provetes
limites_corte = dlmread('Limites_dos_provetes.csv',';');
%
provete = 8; %1 a 6: 67 é 1; 68 é 2, etc.
parte = 2; % 1 é baixo, 2 é topo
fase = 1; % 1 a 5

%
lista_provetes = ['67' ;'68' ;'69' ;'70' ;'71';'72';'73';'74'];
lista_baixo_topo = ['Base'; 'Topo'];
lista_fase = ['1';'2';'3';'4';'5']

provete_str = lista_provetes(provete,:);
parte_str = lista_baixo_topo(parte,:);
fase_str = lista_fase(fase)

provete_str =  strcat('Provete_', provete_str, '_', parte_str, '_', fase_str)
provete_txt = strcat(provete_str,'.txt')

M = csvread(provete_txt); % Importa ficheiro txt

% Limpa erros dos ficheiros
%M(42508,:) = []; %limpeza do erro do 69 base 1

% Determina numero de pontos em cada fiada
freq_amostragem = 0.5 ;% M(2,1) - M(1,1); % Assume-se que a resolução é igual em x e em y
%% Faz matriz de altitudes sem margens

% Limites de x e y 
x_betao_min = 0; % Cria matriz com tudo
x_betao_max = 99999;
y_betao_min = 0;
y_betao_max = 99999;

for m_i = 1 : size(M,1)
    if(M(m_i,1)) >= x_betao_min
        if(M(m_i,1)) <= x_betao_max
            if(M(m_i,2))>= y_betao_min
                if(M(m_i,2))<= y_betao_max
                    aux_x = M(m_i,1) - x_betao_min;
                    aux_y = M(m_i,2) - y_betao_min;
                    ind_x = aux_x / freq_amostragem;
                    ind_y = aux_y / freq_amostragem;
                    if rem(ind_x,1) == 0
                        if rem(ind_y,1) == 0
                            Z(ind_y+1,ind_x+1) = M(m_i,3);
                        end
                    end
                end
            end
        end
    end
end
%% Cria matriz cortada
x_betao_min = limites_corte(1,(provete-1)*2+parte) % Ver ficheiro "Limites_dos_provetes.xls"
x_betao_max = limites_corte(2,(provete-1)*2+parte)
y_betao_min = limites_corte(3,(provete-1)*2+parte)
y_betao_max = limites_corte(4,(provete-1)*2+parte)

Z_original = Z;
Z_crop= Z(y_betao_min/freq_amostragem:y_betao_max/freq_amostragem,x_betao_min/freq_amostragem:x_betao_max/freq_amostragem)
Z = Z_crop; clear Z_crop;

min_Z = min(min(Z)); clear lixo
Z = Z - min_Z;
%% Plota, calcula tamanho e area e salva

figure; surf(Z_original);
figure; surf(Z);

% Calcula dimensoes

dimensoes = (size(Z)-1) * freq_amostragem
area = dimensoes(1)*dimensoes(2)

save(provete_str,'Z','freq_amostragem','provete','parte','fase')