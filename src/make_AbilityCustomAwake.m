function [abilityMat, customMat, awakeMat] = make_AbilityCustomAwake(app)

input=[];

%input = readcell('ability_data/ability');
%abilityMat = zeros(size(input,1)-1, size(input,2)-1);
load('ability_data/ability.mat');
for ii=2:size(input,1)
    for jj=2:size(input,2)
        abilityMat(ii-1,jj-1)=input{ii,jj};
    end
end
abilityMat(34:36,:) = app.ratioSaika * abilityMat(34:36,:);
abilityMat(15:21,:) = app.ratioChallenger * abilityMat(15:21,:);
abilityMat(31:33,:) = app.ratioFull * abilityMat(31:33,:);
abilityMat(44:45,:) = app.ratioDragon * abilityMat(44:45,:);
if app.physicalMonster < 45
    abilityMat(22:24,:) = 0 * abilityMat(22:24,:);
else
    if app.DropDown.Value == '‚È‚µ'
        abilityMat(22,2) = 10;
        abilityMat(23,2) = 5;
        abilityMat(24,2) = 15;
    end
end
abilityMat = abilityMat';

%input = readcell('ability_data/custom');
%customMat = zeros(size(input,1)-1, size(input,2)-1);
load('ability_data/custom.mat');
for ii=2:size(input,1)
    for jj=2:size(input,2)
        customMat(ii-1,jj-1)=input{ii,jj};
    end
end
customMat = customMat';

%input = readcell('ability_data/awake');
%awakeMat = zeros(size(input,1)-1, size(input,2)-1);
load('ability_data/awake.mat');
for ii=2:size(input,1)
    for jj=2:size(input,2)
        awakeMat(ii-1,jj-1)=input{ii,jj};
    end
end
awakeMat = awakeMat';



