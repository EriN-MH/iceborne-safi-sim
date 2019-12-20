
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

%%%����F�e�h��̍ő���͂P��
%%%����F�����i�̌��ɖ������Ȃ��悤

ability = optimvar('ability',45,'Type','integer','LowerBound',0,'UpperBound',1);


custom = optimvar('custom',16,'Type','integer','LowerBound',0,'UpperBound',1);

%%%����F�J�X�^�������̍��v�R�X�g

awake = optimvar('awake',28,'Type','integer','LowerBound',0,'UpperBound',5);
awakeSkills = optimvar('awakeSkill',100,'Type','integer','LowerBound',0,'UpperBound',1);

%%%����F���x���U�͈�܂�
%%%����F�X�L���͂P�܂�
%%%����F�X���b�g�͈�܂�

realAttack = optimvar('realAttack',1,'Type','integer','LowerBound',0);
realElement = optimvar('realElement',1,'Type','integer','LowerBound',0);

caseIndexSet = [];
caseIndexSet{1} = [0;1;2;3]; %����S
caseIndexSet{2} = 80:5:100; %��S������
caseIndexSet{3} = 40:10:140; %�a�ꖡ�����ʒu
caseIndexSet{4} = [0;1;2;3]; %offensive guard
caseIndexSet{5} = [0;1]; %�B�l�|
caseIndexSet{6} = [0;1]; %�ƕ�
caseIndexSet{7} = [0;1]; %������S
caseIndexSet{8} = [0;1]; %�^������S

NS = size(ExtractedSkills);
%%%%%%%%%%�������
%%%�e�X�L���͏���l�܂�
equipprob.Constraints.cons1 =...
    equipMat(1:NS,:) * equip <= limitedPoints;

%%%�����ō���X�L�������ۂ̃X�L���|�C���g�ƈ�v
equipprob.Constraints.cons2 =...
    equipMat(1:NS,:) * equip == skillPoints;

%%%�e�h��͂P�܂�
equipprob.Constraints.cons3 =...
    equipMat((NS+NSS+1):(NS+NSS+6),:) * equip <= ones(6,1);

%%%�e�X�L�����w��̃|�C���g�𒴂��Ă��邩
equipprob.Constraints.cons4 =...
    equipMat(1:NS,:) * equip >= givenPoints;

%%%�V���[�Y�X�L�������ۂ̃|�C���g�ƈ�v
equipprob.Constraints.cons5 =...
    equipMat((NS+1):(NS+NSS),:) * equip + awakeSkillsMat * awakeSkills == seriesPoints;

%%%�����i�̌��̐�����
equipprob.Constraints.cons6 =...
    equipMat((NS+NSS+7):(NS+NSS+10),:) * equip + awakeMat(5:8,:) * awake + customMat(5:8,:) * custom...
    + weaponDeco >= zeros(4,1);

%%%�J�X�^�������̎��Ȑ�����
equipprob.Constraints.cons7 =...
    GenMonotoneMat([4;4;4;4;]) * custom >= zeros(16,1);

%%%�J�X�^�������̃R�X�g
equipprob.Constraints.cons8 =...
    customMat(9,:) * custom + costCustomHealth <= 6;

%%%�����\�͂̎��Ȑ�����
equipprob.Constraints.cons9 =...
    GenMonotoneMat([7;7;7;3;6;3;3;2;5;2]) * ability >= zeros(45,1);

%%%�U��
equipprob.Constraints.cons10 =...
    ones(1,7) * ability(1:7) <= aaaaaaaaaaaaaaaaaa;

%%%���؂�
equipprob.Constraints.cons11 =...
    ones(1,7) * ability(8:14) <= aaaaaaaaaaaaaaaaaa;

%%%�����
equipprob.Constraints.cons12 =...
    ones(1,7) * ability(15:21) <= aaaaaaaaaaaaaaaaaa;
equipprob.Constraints.cons13 =...
    bbbbbbbbbbbbbbbb - 3*ability(20) >= 0; % bbbbb�͒���V���[�Y�X�L���|�C���g

%%%��_����
equipprob.Constraints.cons14 =...
    ones(1,3) * ability(22:24) <= aaaaaaaaaaaaaaaaaaaa;

%%%����
equipprob.Constraints.cons15 =...
    ones(1,6) * ability(25:30) <= aaaaaaaaaaaaaaaaaaaa;

%%%�t���`���[�W
equipprob.Constraints.cons16 =...
    ones(1,3) * ability(31:33) <= aaaaaaaaaaaaaaaaaaaa;

%%%�Љ�
equipprob.Constraints.cons16 =...
    ones(1,3) * ability(34:36) <= aaaaaaaaaaaaaaaaaaaa;

%%%��������
equipprob.Constraints.cons17 =...
    ones(1,2) * ability(37:38) <= aaaaaaaaaaaaaaaaaaaa;

%%%��
equipprob.Constraints.cons18 =...
    ones(1,5) * ability(39:43) <= aaaaaaaaaaaaaaaaaaaa;

%%%����
equipprob.Constraints.cons19 =...
    ones(1,2) * ability(44:45) <= aaaaaaaaaaaaaaaaaaaa;

%%%���ۂ̍U����
equipprob.Constraints.cons20 =...
    abilityMat(1,:)*ability + customMat(1,:)*custom + awakeMat(1,:)*awake + weaponAttack - realAttack <= 0;

%%%���ۂ̑���
equipprob.Constraints.cons21 =...
    abilityMat(3,:)*ability + customMat(3,:)*custom + awakeMat(3,:)*awake + weaponElement - realElement <= 0;

%%%���ۂ̉�S
equipprob.Constraints.cons22 =...
    abilityMat(2,:)*ability + customMat(2,:)*custom + awakeMat(2,:)*awake + weaponCritical - realCritical <= 0;

%%%�o���̌�����T
equipprob.Constraints.cons23 =...
    ones(1,28)*awake + ones(1,size(awakeSkills))*awakeSkills <= 5;

%%%�o���̃X�L������P
equipprob.Constraints.cons24 =...
    ones(1,size(awakeSkills))*awakeSkills <= 1;

%%%�o�����x���U�̏���P
equipprob.Constraints.cons25 =...
    awake(6)+awake(12)+awake(18)+awake(24) <= 1;

%%%�o���X���b�g���1
equipprob.Constraints.cons26 =...
    sum(awake(25:28)) <= 1;








