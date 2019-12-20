
equipprob = optimproblem;

%%%%%
NS = size(ExtractedSkills);
NSS = size(ExtractedSeriesSkills);
head = optimvar('head',100,'Type','integer','LowerBound',0,'UpperBound',1);
body = optimvar('body',100,'Type','integer','LowerBound',0,'UpperBound',1);
arm = optimvar('arm',100,'Type','integer','LowerBound',0,'UpperBound',1);
wst = optimvar('wst',100,'Type','integer','LowerBound',0,'UpperBound',1);
leg = optimvar('leg',100,'Type','integer','LowerBound',0,'UpperBound',1);
charm = optimvar('charm',100,'Type','integer','LowerBound',0,'UpperBound',1);
deco = optimvar('deco',100,'Type','integer','LowerBound',0);
equip = [head;body;arm;wst;leg;charm;deco];
skillPoints = optimvar('head',NS,'Type','integer','LowerBound',0);
seriesPoints = optimvar('head',NSS,'Type','integer','LowerBound',0);
%%%%%

%%%制約：各防具の最大個数は１個
%%%制約：装飾品の個数に矛盾がないよう

ability = optimvar('ability',45,'Type','integer','LowerBound',0,'UpperBound',1);


custom = optimvar('custom',16,'Type','integer','LowerBound',0,'UpperBound',1);

%%%制約：カスタム強化の合計コスト

awake = optimvar('awake',28,'Type','integer','LowerBound',0,'UpperBound',5);
awakeSkills = optimvar('awakeSkill',100,'Type','integer','LowerBound',0,'UpperBound',1);

%%%制約：レベル６は一個まで
%%%制約：スキルは１個まで
%%%制約：スロットは一個まで

realAttack = optimvar('realAttack',1,'Type','integer','LowerBound',0);
realElement = optimvar('realElement',1,'Type','integer','LowerBound',0);

caseIndexSet = [];
caseIndexSet{1} = [0;1;2;3]; %超会心
caseIndexSet{2} = 80:5:100; %会心率下限
caseIndexSet{3} = 40:10:140; %斬れ味初期位置
caseIndexSet{4} = [0;1;2;3]; %offensive guard
caseIndexSet{5} = [0;1]; %達人芸
caseIndexSet{6} = [0;1]; %業物
caseIndexSet{7} = [0;1]; %属性会心
caseIndexSet{8} = [0;1]; %真属性会心

NS = size(ExtractedSkills);
%%%%%%%%%%制約条件
%%%各スキルは上限値まで
equipprob.Constraints.cons1 =...
    equipMat(1:NS,:) * equip <= limitedPoints;

%%%装備で作れるスキルが実際のスキルポイントと一致
equipprob.Constraints.cons2 =...
    equipMat(1:NS,:) * equip == skillPoints;

%%%各防具は１個まで
equipprob.Constraints.cons3 =...
    equipMat((NS+NSS+1):(NS+NSS+6),:) * equip <= ones(6,1);

%%%各スキルが指定のポイントを超えているか
equipprob.Constraints.cons4 =...
    equipMat(1:NS,:) * equip >= givenPoints;

%%%シリーズスキルが実際のポイントと一致
equipprob.Constraints.cons5 =...
    equipMat((NS+1):(NS+NSS),:) * equip + awakeSkillsMat * awakeSkills == seriesPoints;

%%%装飾品の個数の整合性
equipprob.Constraints.cons6 =...
    equipMat((NS+NSS+7):(NS+NSS+10),:) * equip + awakeMat(5:8,:) * awake + customMat(5:8,:) * custom...
    + weaponDeco >= zeros(4,1);

%%%カスタム強化の自己整合性
equipprob.Constraints.cons7 =...
    GenMonotoneMat([4;4;4;4;]) * custom >= zeros(16,1);

%%%カスタム強化のコスト
equipprob.Constraints.cons8 =...
    customMat(9,:) * custom + costCustomHealth <= 6;

%%%発動能力の自己整合性
equipprob.Constraints.cons9 =...
    GenMonotoneMat([7;7;7;3;6;3;3;2;5;2]) * ability >= zeros(45,1);

%%%攻撃
equipprob.Constraints.cons10 =...
    ones(1,7) * ability(1:7) <= aaaaaaaaaaaaaaaaaa;

%%%見切り
equipprob.Constraints.cons11 =...
    ones(1,7) * ability(8:14) <= aaaaaaaaaaaaaaaaaa;

%%%挑戦者
equipprob.Constraints.cons12 =...
    ones(1,7) * ability(15:21) <= aaaaaaaaaaaaaaaaaa;
equipprob.Constraints.cons13 =...
    bbbbbbbbbbbbbbbb - 3*ability(20) >= 0; % bbbbbは挑戦シリーズスキルポイント

%%%弱点特効
equipprob.Constraints.cons14 =...
    ones(1,3) * ability(22:24) <= aaaaaaaaaaaaaaaaaaaa;

%%%属性
equipprob.Constraints.cons15 =...
    ones(1,6) * ability(25:30) <= aaaaaaaaaaaaaaaaaaaa;

%%%フルチャージ
equipprob.Constraints.cons16 =...
    ones(1,3) * ability(31:33) <= aaaaaaaaaaaaaaaaaaaa;

%%%災禍
equipprob.Constraints.cons16 =...
    ones(1,3) * ability(34:36) <= aaaaaaaaaaaaaaaaaaaa;

%%%属性加速
equipprob.Constraints.cons17 =...
    ones(1,2) * ability(37:38) <= aaaaaaaaaaaaaaaaaaaa;

%%%匠
equipprob.Constraints.cons18 =...
    ones(1,5) * ability(39:43) <= aaaaaaaaaaaaaaaaaaaa;

%%%龍脈
equipprob.Constraints.cons19 =...
    ones(1,2) * ability(44:45) <= aaaaaaaaaaaaaaaaaaaa;

%%%実際の攻撃力
equipprob.Constraints.cons20 =...
    abilityMat(1,:)*ability + customMat(1,:)*custom + awakeMat(1,:)*awake + weaponAttack - realAttack <= 0;

%%%実際の属性
equipprob.Constraints.cons21 =...
    abilityMat(3,:)*ability + customMat(3,:)*custom + awakeMat(3,:)*awake + weaponElement - realElement <= 0;

%%%実際の会心
equipprob.Constraints.cons22 =...
    abilityMat(2,:)*ability + customMat(2,:)*custom + awakeMat(2,:)*awake + weaponCritical - realCritical <= 0;

%%%覚醒の個数上限５
equipprob.Constraints.cons23 =...
    ones(1,28)*awake + ones(1,size(awakeSkills))*awakeSkills <= 5;

%%%覚醒のスキル上限１
equipprob.Constraints.cons24 =...
    ones(1,size(awakeSkills))*awakeSkills <= 1;

%%%覚醒レベル６の上限１
equipprob.Constraints.cons25 =...
    awake(6)+awake(12)+awake(18)+awake(24) <= 1;

%%%覚醒スロット上限1
equipprob.Constraints.cons26 =...
    sum(awake(25:28)) <= 1;








