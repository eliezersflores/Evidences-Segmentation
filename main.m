clear all; close all; clc; tic;
addpath('/home/eliezerflores/Matlab/ompbox10');
addpath('/home/eliezerflores/Matlab/ksvdbox13');

%% Parameters:

evidenceSize = 25; % Divide images in evidenceSize x evidenceSize squares.
totalBens = 40; totalMals = 40;

%% Generate data:

[Y,Yt,C,Ct,isTrain] = evidencesGenerateWindows(evidenceSize,totalBens,totalMals,'distinct');

%multiDimPlot(Y,C); title('Original Data (Star Coordinate):'); legend('Normal Skin','Lesion');

% larger 'boxcontraint' -> less training error -> more overfittying
options = statset('Display','iter','MaxIter',1000000);
mdl = svmtrain(Y',C,'kernel_function','linear','boxconstraint',1,'options',options);

Cp = svmclassify(mdl,Yt');
%Cp = svmclassify(mdl,Y');

conf = confusionmat(Cp,Ct');
%conf = confusionmat(Cp,C');

accuracy = sum(diag(conf))/sum(conf(:));

%% KSVD:

params.data = Y;
params.Tdata = 100;
params.dictsize = 4000;
params.iternum = 10;
params.memusage = 'high';
[D,~,~] = ksvd(params);
X = omp(D'*Y,D'*D,params.Tdata);

multiDimPlot(X,C); title('KSVD Coefficients (Star Coordinate):'); legend('Normal Skin','Lesion','Boarder')

%%

[invDict,Coeff] = informationTheoretic(Y,C,D,X,params,3);
multiDimPlot(X,C); title('Information-Theoretic Coefficients (Star Coordinate):'); legend('Normal Skin','Lesion','Boarder')
save('dataInfoTheoretic','invDict','coeff');
%%

toc;