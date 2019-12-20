function [sol,fval,NameCollection]...
    = solve_prob(app,equipMat, NameCollection, SizeCollection,...
                abilityMat, customMat, awakeMat,...
                ExtractedSkills, ExtractedSeriesSkills, limitedPoints)

%%%%%%%%%%%%%%%%%%%%%%%%
costCustomHealth=app.costCustomHealth;
weaponDeco=app.weaponDeco;
elementLocation=app.elementLocation;
weaponAttack=app.weaponAttack;
weaponElement=app.weaponElement;
weaponCritical=app.weaponCritical;
physicalMonster=app.physicalMonster;
Mvalue=app.Mvalue;
elementalMonster=app.elementalMonster;
NumHit=app.NumHit;
razorLength=app.razorLength;

criticalBoost=app.criticalBoost;
offensiveGuard=app.offensiveGuard;
elemCrit=app.elemCrit;
elemCritTrue=app.elemCritTrue;
realCritical=app.realCritical;
initSharp=app.initSharp;
Wazamono=app.Wazamono;
Tatsuzingei=app.Tatsuzingei;

givenPoints = app.givenPoints;
%%%%%%%%%%%%%%%%%%%%%%%%



%[ExtractedSkills, ExtractedSeriesSkills, limitedPoints] = load_skillsList();
NS = size(ExtractedSkills,1);
NSS = size(ExtractedSeriesSkills,1);

%[equipMat, NameCollection, SizeCollection]...
%    = make_data([ExtractedSkills;ExtractedSeriesSkills]');
%[abilityMat, customMat, awakeMat] = make_AbilityCustomAwake();

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
head = optimvar('aa_head',SizeCollection(1),'Type','integer','LowerBound',0,'UpperBound',1);
body = optimvar('ab_body',SizeCollection(2),'Type','integer','LowerBound',0,'UpperBound',1);
arm = optimvar('ac_arm',SizeCollection(3),'Type','integer','LowerBound',0,'UpperBound',1);
wst = optimvar('ad_wst',SizeCollection(4),'Type','integer','LowerBound',0,'UpperBound',1);
leg = optimvar('ae_leg',SizeCollection(5),'Type','integer','LowerBound',0,'UpperBound',1);
charm = optimvar('af_charm',SizeCollection(6),'Type','integer','LowerBound',0,'UpperBound',1);
deco = optimvar('ag_deco',SizeCollection(7),'Type','integer','LowerBound',0);
equip = [head;body;arm;wst;leg;charm;deco];
skillPoints = optimvar('ah_skillPoints',NS,'Type','integer','LowerBound',0);
seriesPoints = optimvar('ai_seriesPoints',NSS,'Type','integer','LowerBound',0);

ability = optimvar('ba_ability',45,'Type','integer','LowerBound',0,'UpperBound',1);
custom = optimvar('bb_custom',16,'Type','integer','LowerBound',0,'UpperBound',1);
awake = optimvar('bc_awake',28,'Type','integer','LowerBound',0,'UpperBound',5);
awakeSkills = optimvar('bd_awakeSkill',NSS,'Type','integer','LowerBound',0,'UpperBound',1);

realAttack = optimvar('be_realAttack',1,'Type','integer','LowerBound',0);
realElement = optimvar('bf_realElement',1,'Type','integer','LowerBound',0);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[physicalModi, elementalModi]...
    = calc_modification(initSharp,...
    razorLength*(1/(1+Wazamono))*(1-Tatsuzingei*realCritical/100)+1);
physicalCoff = physicalMonster * Mvalue...
    * physicalModi * (1+0.05*offensiveGuard*app.ratioOG)...
    * ( 1 + (0.25+0.05*criticalBoost)*(realCritical/100) )/10000;
elementalCoff = elementalMonster * NumHit * elementalModi...
    * ( 1 + (0.35*elemCrit + 0.55*elemCritTrue)*(realCritical/100))/1000;
equipprob = optimproblem('Objective',...
    (-1)*realAttack*physicalCoff + (-1)*realElement*elementalCoff);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% �e�X�L���͏���l�܂Łi���O�X�L���͂����ŏ���l��}���邱�ƂŎw��j
equipprob.Constraints.cons1 =...
    equipMat(1:(NS+NSS),:) * equip <= limitedPoints;

%%% �����ō���X�L��(�V���[�Y�X�L������)�����ۂ̃X�L���|�C���g�ƈ�v
equipprob.Constraints.cons2 =...
    equipMat(1:NS,:) * equip + (-1)* skillPoints == zeros(NS,1);

%%% �e�h��E��΂͂P�܂�
equipprob.Constraints.cons3 =...
    equipMat((NS+NSS+5):(NS+NSS+10),:) * equip <= ones(6,1);

%%% �e�X�L�����w��̃|�C���g�𒴂��Ă��邩
equipprob.Constraints.cons4 =...
    equipMat(1:(NS+NSS),:) * equip >= givenPoints;

%%% �V���[�Y�X�L�������ۂ̃|�C���g�ƈ�v
equipprob.Constraints.cons5 =...
    equipMat((NS+1):(NS+NSS),:) * equip + awakeSkills - seriesPoints == zeros(NSS,1);

%%% �����i�̌��̐�����
equipprob.Constraints.cons6 =...
    equipMat((NS+NSS+1):(NS+NSS+4),:) * equip...
    + awakeMat(5:8,:) * awake + customMat(5:8,:) * custom...
    + weaponDeco >= zeros(4,1);

%%% �J�X�^�������̎��Ȑ�����
equipprob.Constraints.cons7 =...
    GenMonotoneMat([4;4;4;4;]) * custom >= zeros(12,1);

%%% �J�X�^�������̃R�X�g
equipprob.Constraints.cons8 =...
    customMat(9,:) * custom + costCustomHealth <= 6;

%%% �����\�͂̎��Ȑ�����
equipprob.Constraints.cons9 =...
    GenMonotoneMat([7;7;7;3;6;3;3;2;5;2]) * ability >= zeros(35,1);

%%% �U��
equipprob.Constraints.cons10 =...
    ones(1,7) * ability(1:7) - skillPoints(1) <= 0;

%%% ���؂�
equipprob.Constraints.cons11 =...
    ones(1,7) * ability(8:14) - skillPoints(2) <= 0;

%%% �����
equipprob.Constraints.cons12 =...
    ones(1,7) * ability(15:21) - skillPoints(3) <= 0;
equipprob.Constraints.cons13 =...
    seriesPoints(2) - 3*ability(20) >= 0; % seriesPoints(2)�͒���V���[�Y�X�L���|�C���g

%%% ��_����
equipprob.Constraints.cons14 =...
    ones(1,3) * ability(22:24) - skillPoints(4) <= 0;

%%% ����
equipprob.Constraints.cons15 =...
    ones(1,6) * ability(25:30) - skillPoints(elementLocation) <= 0;

%%% �t���`���[�W
equipprob.Constraints.cons16 =...
    ones(1,3) * ability(31:33) - skillPoints(21) <= 0;

%%% �Љ�
equipprob.Constraints.cons16 =...
    ones(1,3) * ability(34:36) - skillPoints(15) <= 0;

%%% ��������
equipprob.Constraints.accel1 =...
    2*ability(37) - seriesPoints(5) <= 0;
equipprob.Constraints.accel1 =...
    4*ability(38) - seriesPoints(5) <= 0;

%%% ��
equipprob.Constraints.cons18 =...
    ones(1,5) * ability(39:43) - skillPoints(16) <= 0;

%%% ����
equipprob.Constraints.dragon1 =...
    3*ability(44) - seriesPoints(3) <= 0;
equipprob.Constraints.dragon2 =...
    5*ability(45) - seriesPoints(3) <= 0;

%%% ���ۂ̍U����
equipprob.Constraints.cons20 =...
    abilityMat(1,:)*ability + customMat(1,:)*custom...
    + awakeMat(1,:)*awake + weaponAttack - realAttack >= 0;

%%% ���ۂ̑���
equipprob.Constraints.cons21 =...
    abilityMat(3,:)*ability + customMat(3,:)*custom...
    + awakeMat(3,:)*awake + weaponElement - realElement >= 0;

%%% ���ۂ̉�S
equipprob.Constraints.cons22 =...
    abilityMat(2,:)*ability + customMat(2,:)*custom...
    + awakeMat(2,:)*awake + weaponCritical - realCritical >= 0;

%%% �o���̌�����T
equipprob.Constraints.cons23 =...
    ones(1,28)*awake + ones(1,size(awakeSkills,1))*awakeSkills <= 5;

%%% �o���̃X�L������P
equipprob.Constraints.cons24 =...
    ones(1,size(awakeSkills,1))*awakeSkills <= 1;

%%% �o�����x���U�̏���P
equipprob.Constraints.cons25 =...
    awake(6)+awake(12)+awake(18)+awake(24) <= 1;

%%% �o���X���b�g���1
equipprob.Constraints.cons26 =...
    sum(awake(25:28)) <= 1;

%%% �a�ꖡ�̏���
equipprob.Constraints.cons27 =...
    abilityMat(4,:)*ability + customMat(4,:)*custom...
    + awakeMat(4,:)*awake + 40 - initSharp >= 0;

%%% �o���X�L���ɐԗ��͕s��
equipprob.Constraints.cons28 =...
    awakeSkills(3) == 0;

problem = prob2struct(equipprob);
[sol,fval,exitflag,output] = intlinprog(problem);

fval = (-1)*fval;

