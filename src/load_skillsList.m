function [ExtractedSkills, ExtractedSeriesSkills, limitedPoints] = load_skillsList()

limitedPoints = [];

input = readcell('ability_data/extractedskills');
ExtractedSkills = [];
for ii=1:size(input,1)
    ExtractedSkills = [ExtractedSkills;string(input{ii,1})];
    limitedPoints = [limitedPoints;input{ii,2}];
end

input = readcell('ability_data/seriesskills');
ExtractedSeriesSkills = [];
for ii=1:size(input,1)
    ExtractedSeriesSkills = [ExtractedSeriesSkills;string(input{ii,1})];
    limitedPoints = [limitedPoints;input{ii,2}];
end