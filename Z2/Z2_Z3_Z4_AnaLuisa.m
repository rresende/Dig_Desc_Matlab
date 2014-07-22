clear all; close all;clc; %Limpa as variáveis

load 'Provete_71_Topo_3';

dim_Z_=size(Z);
dx=0.5;

l=(0:0.5:dim_Z_(1,1)/2-0.5)';
c=0:0.5:dim_Z_(1,2)/2-0.5;

Z=[c;Z];
dim_Z=size(Z);

for i=1:dim_Z(1,1)
    for j=1:dim_Z(1,2)         
        P=Z(:,[1:2*dx:dim_Z(1,2)]);
    end
end

P(1,:)=[];
P=[l P];
dim_P=size(P);

for i=1:dim_P(1,1)
    for j=1:dim_P(1,2)
        A=P([1:2*dx:dim_P(1,1)],:);
    end
end

A(:,1)=[];
Z=A;
Z=Z';
dim_Z=size(Z);

for j=1:dim_Z(1,2)
    for i=1:(dim_Z(1,1))
        produto_RMS(i,j)=Z(i,j)^2;
        somatorio_RMS(1,j)=sum(produto_RMS(:,j));
        soma_RMS(1,1)=sum(somatorio_RMS');
        media_RMS=soma_RMS/((i)*j);
        RMS=sqrt(media_RMS);
    end
end


for j=1:dim_Z(1,2)
    for i=1:(dim_Z(1,1)-1)
        if i>=1
        dif_Z2(i,j)=((Z(i+1,j)-Z(i,j))/dx)^2;
        somatorio_Z2(1,j)=sum(dif_Z2(:,j));
        soma_Z2(1,1)=sum(somatorio_Z2');
        media_Z2=soma_Z2/((i)*j);
        Z2=sqrt(media_Z2);
        end
    end
end

%save('Provete_67_topo_1','RMS','Z2')




% for j=1:dim_Z(1,2)
%     for i=2:(dim_Z(1,1)-1)
%         if i>=2
%         dif_Z3(i,j)=((Z(i-1,j)-2*Z(i,j)+Z(i+1,j))/dx^2)^2;
%         somatorio_Z3(1,j)=sum(dif_Z3(:,j));
%         soma_Z3(1,1)=sum(somatorio_Z3');
%         media_Z3=soma_Z3/((i-1)*j);
%         Z3=sqrt(media_Z3);
%         end
%     end
% end



    