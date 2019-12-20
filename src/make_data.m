function [TransMat, NameCollection, SizeCollection] = make_data(TotalSkills)

[Vector_ARM,Name_ARM] = vectorize_armor('data/MHW_EQUIP_ARM.xlsx', TotalSkills);
Vector_ARM = [Vector_ARM ones(size(Vector_ARM,1),1)*[0 0 1 0 0 0]];
[Vector_BODY,Name_BODY] = vectorize_armor('data/MHW_EQUIP_BODY.xlsx', TotalSkills);
Vector_BODY = [Vector_BODY ones(size(Vector_BODY,1),1)*[0 1 0 0 0 0]];
[Vector_HEAD,Name_HEAD] = vectorize_armor('data/MHW_EQUIP_HEAD.xlsx', TotalSkills);
Vector_HEAD = [Vector_HEAD ones(size(Vector_HEAD,1),1)*[1 0 0 0 0 0]];
[Vector_LEG,Name_LEG] = vectorize_armor('data/MHW_EQUIP_LEG.xlsx', TotalSkills);
Vector_LEG = [Vector_LEG ones(size(Vector_LEG,1),1)*[0 0 0 0 1 0]];
[Vector_WST,Name_WST] = vectorize_armor('data/MHW_EQUIP_WST.xlsx', TotalSkills);
Vector_WST = [Vector_WST ones(size(Vector_WST,1),1)*[0 0 0 1 0 0]];
[Vector_CHARM,Name_CHARM] = vectorize_charm('data/MHW_CHARM.xlsx', TotalSkills);
Vector_CHARM = [Vector_CHARM ones(size(Vector_CHARM,1),1)*[0 0 0 0 0 0 0 0 0 1]];
[Vector_DECO,Name_DECO] = vectorize_deco('data/MHW_DECO.xlsx', TotalSkills);
Vector_DECO = [Vector_DECO ones(size(Vector_DECO,1),1)*[0 0 0 0 0 0]];

TransMat = [Vector_HEAD;Vector_BODY;Vector_ARM;Vector_WST;Vector_LEG;...
    Vector_CHARM;Vector_DECO]';
NameCollection = [Name_HEAD;Name_BODY;Name_ARM;Name_WST;Name_LEG;Name_CHARM;Name_DECO];
SizeCollection = [size(Vector_HEAD,1);size(Vector_BODY,1);size(Vector_ARM,1);...
    size(Vector_WST,1);size(Vector_LEG,1);size(Vector_CHARM,1);size(Vector_DECO,1);];
