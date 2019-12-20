
physicalMonster=60;
Mvalue=95;
elementalMonster=20;
NumHit=5;
realAttack=300;
realElement=500;
realCritical=80;

[physicalModi, elementalModi] = calc_modification(60, 40);
physicalCoff = physicalMonster*Mvalue*physicalModi...
    *(1+(0.25+0.05*3)*(realCritical/100))/10000;
elementalCoff = elementalMonster*NumHit*elementalModi...
    *(1+0.35*(realCritical/100))/1000;


a=realAttack*physicalCoff
b=realElement*elementalCoff