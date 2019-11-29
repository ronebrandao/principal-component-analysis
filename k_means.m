function [ segmented_images,  cluster_center] = k_means( imagem )
%K_MEANS Retorna 3 clusteres separados por cor
%   A função irá receber uma imagem RGB como parâmetro, a transformará para
%   L*a*b e retornar um vetor com 3 imagens separadas por cor.
  
 % Converter de RGB para L*a*b*
 cform = makecform('srgb2lab');
 imagem_lab = applycform(imagem,cform);
 
 % Classificar as cores no Espaço *a*b utilizando k-means clustering
 ab = double(imagem_lab(:,:,2:3));
 nlinhas = size(ab,1);
 ncolunas = size(ab,2);
 ab = reshape(ab,nlinhas*ncolunas,2); % remodela o vetor A utilizando o vetor de tamanho sz
 
 nColors = 3;
 % cluster_idx = index correspondente a cada cluster (nesse caso, 3)
 [cluster_idx, cluster_center] = kmeans(ab,nColors,'distance','sqEuclidean','Replicates',3);
 
 %Marcar todos os pixels na imagem utilizando os resultados do kmeans
 pixel_labels = reshape(cluster_idx,nlinhas,ncolunas);
 % imshow(pixel_labels,[]), title('Imagem rotulada pelo index do cluster');
 
 %Criar imagens dividas por cor
 segmented_images = cell(1,3);
 rgb_label = repmat(pixel_labels, [1 1 3]); % retorna um vetor contendo n cópias de um vetor
                                            % aparentemente ele separa em um
                                            % novo vetor os pixels encontrados
                                            % pelo k-means em um vetor de
                                            % tamanho [1 1 3]
 
 for k = 1:nColors
     color = imagem;
     color(rgb_label ~= k) = 0; % onde o valor do pixel na imagem original 
                                % não corresponder com o valor definido pelo k-means, 
                                % será atribuida a cor preta
     segmented_images{k} = color;
 end
 
end

