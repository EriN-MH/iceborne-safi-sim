function [vector_armor, name_armor] = vectorize_charm(filename, ExtractedSkills)

input = readcell(filename);
vector_armor = zeros( size(input,1), size(ExtractedSkills,2));
name_armor = [];

for ii=1:( size(input,1)-1 )
    if ismissing(input{ii+1,4})>0
        First_Skill = 0;
    else
        First_Skill = ( ExtractedSkills == string(input{ii+1,4}) )...
            * input{ii+1,5};
    end
    if ismissing(input{ii+1,6})>0
        Second_Skill = 0;
    else
        Second_Skill = ( ExtractedSkills == string(input{ii+1,6}) )...
            * input{ii+1,7};
    end
    vector_armor(ii,1:size(ExtractedSkills,2))...
        = First_Skill + Second_Skill;
    
    %%%%% Name
    name_armor = [name_armor;string(input{ii+1,1})];
end

temp = vector_armor(sum(vector_armor(:,1:size(ExtractedSkills,2)),2)>0, :);
temptemp = name_armor(sum(vector_armor(:,1:size(ExtractedSkills,2)),2)>0);
vector_armor = temp;
name_armor = temptemp;