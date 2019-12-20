function app = repRazor(app)

initSharp = app.initSharp;
razorLength = app.razorLength*(1/(1+app.Wazamono))...
    *(1-app.Tatsuzingei*app.realCritical/100)+1;

A=[200 220*ones(1,50) 252*ones(1,50) 238*ones(1,60) 260*ones(1,120) 244*ones(1,80)];
A(1,(initSharp+160):end)=257;
B=257*ones(size(A));
B(1,max([1;initSharp+160-1-razorLength]):initSharp+160-1)=221;

imagesc([A;B],'parent',app.UIAxes2);colormap(app.UIAxes2,colorcube);