
function [physicalModi, elementalModi] = calc_modification(initSharp, razorLength)

supRazor = 50+50+60+initSharp;
infRazor = supRazor - razorLength;

yellow=50;
green=50;
blue=60;
white=0;
purple=0;

if infRazor < 50
    yellow = 50-infRazor;
    if supRazor < 280
        white = supRazor-160;
    else
        white = 120;
        purple = supRazor - 280;
    end
end
if infRazor >= 50 && infRazor < 100
    yellow = 0;
    green = 100-infRazor;
    if supRazor < 280
        white = supRazor-160;
    else
        white = 120;
        purple = supRazor - 280;
    end
end
if infRazor >= 100 && infRazor < 160
    yellow = 0;
    green = 0;
    blue = 160-infRazor;
    if supRazor < 280
        white = supRazor-160;
    else
        white = 120;
        purple = supRazor - 280;
    end
end
if infRazor >= 160
    yellow = 0;
    green = 0;
    blue = 0;
    %blue = 160-infRazor;
    if supRazor < 280
        white = supRazor-infRazor;
    else
        if infRazor <280
            white = 280-infRazor;
            purple = supRazor - 280;
        else
            white = 0;
            purple = supRazor - infRazor;
        end
    end
end



physicalModi = (1.39*purple + 1.32*white + 1.2*blue + 1.05*green + 1*yellow)/razorLength;
elementalModi = (1.2*purple + 1.125*white + 1.0625*blue +1*green + 0.75*yellow)/razorLength;