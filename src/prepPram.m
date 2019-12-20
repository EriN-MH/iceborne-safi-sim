function app = prepPram(app, caseIndexSet, indexSeq)

%app.costCustomHealth=3;
%app.weaponDeco = [1;1;1;1];
%app.elementLocation=8;
%app.weaponAttack = 270;
%app.weaponElement=120;
%app.weaponCritical=5;
%app.physicalMonster=60;
%app.Mvalue=95;
%app.elementalMonster=30;
%app.NumHit=5;
%app.razorLength=100;


%caseIndexSet = [];
%caseIndexSet{1} = [0;1;2;3]; %����S
%caseIndexSet{2} = 80:5:100; %��S������
%caseIndexSet{3} = 40:10:140; %�a�ꖡ�����ʒu
%caseIndexSet{4} = [0;1;2;3]; %offensive guard
%caseIndexSet{5} = [0;1]; %�B�l�|
%caseIndexSet{6} = [0;1]; %�ƕ�
%caseIndexSet{7} = [0;1]; %������S
%caseIndexSet{8} = [0;1]; %�^������S


app.criticalBoost=caseIndexSet{1}(indexSeq(1));
app.offensiveGuard = caseIndexSet{4}(indexSeq(4));
app.elemCrit=caseIndexSet{7}(indexSeq(7));
app.elemCritTrue=caseIndexSet{8}(indexSeq(8));
app.realCritical=caseIndexSet{2}(indexSeq(2));
app.initSharp=caseIndexSet{3}(indexSeq(3));
app.Wazamono = caseIndexSet{6}(indexSeq(6));
app.Tatsuzingei = caseIndexSet{5}(indexSeq(5));

app.givenPoints=[0;0;0;0;app.criticalBoost;...
    app.givenGuardAbi;app.givenGuardPow;...
    0;0;0;0;0;0;app.offensiveGuard;0;0;app.Wazamono;...
    app.givenUp;0;app.givenFocus;0;app.givenHealth;...
    3*app.Tatsuzingei;0;0;4*app.elemCritTrue;0;2*app.elemCrit];
%app.givenPoints
