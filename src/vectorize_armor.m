function [vector_armor, name_armor]...
    = vectorize_armor(filename, ExtractedSkills)

input = readcell(filename);
vector_armor = zeros( size(input,1), size(ExtractedSkills,2)+4 );
name_armor = [];

for ii=1:( size(input,1)-1 )%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if ismissing(input{ii+1,15})>0
        First_Skill = 0;
    else
        First_Skill = ( ExtractedSkills == string(input{ii+1,15}) )...
            * input{ii+1,16};
    end
    if ismissing(input{ii+1,17})>0
        Second_Skill = 0;
    else
        Second_Skill = ( ExtractedSkills == string(input{ii+1,17}) )...
            * input{ii+1,18};
    end
    if ismissing(input{ii+1,19})>0
        Third_Skill = 0;
    else
        Third_Skill = ( ExtractedSkills == string(input{ii+1,19}) )...
            * input{ii+1,20};
    end
    vector_armor(ii,1:size(ExtractedSkills,2))...
        = First_Skill + Second_Skill + Third_Skill;
    
    %%%%% Deco %%%%%
    if input{ii+1,4}>0
        for jj=1:input{ii+1,4}
            vector_armor(ii,size(ExtractedSkills,2)+jj)...
                = vector_armor(ii,size(ExtractedSkills,2)+jj) + 1;
        end
    end
    if input{ii+1,5}>0
        for jj=1:input{ii+1,5}
            vector_armor(ii,size(ExtractedSkills,2)+jj)...
                = vector_armor(ii,size(ExtractedSkills,2)+jj) + 1;
        end
    end
    if input{ii+1,6}>0
        for jj=1:input{ii+1,6}
            vector_armor(ii,size(ExtractedSkills,2)+jj)...
                = vector_armor(ii,size(ExtractedSkills,2)+jj) + 1;
        end
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %%%%% Name
    name_armor = [name_armor;string(input{ii+1,1})];
end

temp = vector_armor(sum(vector_armor(:,1:size(ExtractedSkills,2)),2)>0, :);
temptemp = name_armor(sum(vector_armor(:,1:size(ExtractedSkills,2)),2)>0);
vector_armor = temp;
name_armor = temptemp;