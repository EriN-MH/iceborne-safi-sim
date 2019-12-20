function [vector_armor, name_armor] = vectorize_deco(filename, ExtractedSkills)

input = readcell(filename);
vector_armor = zeros( size(input,1), size(ExtractedSkills,2) + 4);
name_armor = [];

for ii=1:( size(input,1)-1 )
    %if input{ii+1,3} <= slot_size
    
    if ismissing(input{ii+1,5})>0
        First_Skill = 0;
    else
        First_Skill = ( ExtractedSkills == string(input{ii+1,5}) )...
            * input{ii+1,6};
    end
    if ismissing(input{ii+1,7})>0
        Second_Skill = 0;
    else
        Second_Skill = ( ExtractedSkills == string(input{ii+1,7}) )...
            * input{ii+1,8};
    end
    vector_armor(ii,1:size(ExtractedSkills,2))...
        = First_Skill + Second_Skill;
    
    %end
    
    if input{ii+1,3}>0
        for jj=1:input{ii+1,3}
            vector_armor(ii,size(ExtractedSkills,2)+jj)...
                = vector_armor(ii,size(ExtractedSkills,2)+jj) - 1;
        end
    end
    
    %%%%% Name
    name_armor = [name_armor;string(input{ii+1,1})];
    
    
end

temp = vector_armor(sum(vector_armor(:,1:size(ExtractedSkills,2)),2)>0, :);
temptemp = name_armor(sum(vector_armor(:,1:size(ExtractedSkills,2)),2)>0);
vector_armor = temp;
name_armor = temptemp;