function result = GenMonotoneMat(sublength)

%sublength = [7;7;7;3;6;3;3;2;5;2];

result = zeros(sum(sublength-1), sum(sublength));
    for jj=1:(sublength(1)-1)
        result(jj,jj)=1;
        result(jj,jj+1)=-1;
    end
    for jj=2:size(sublength,1)
        for kk=1:(sublength(jj)-1)
            temp = sum(sublength(1:(jj-1)))-(jj-1);
            result(temp+kk, sum(sublength(1:(jj-1)))+kk)=1;
            result(temp+kk, sum(sublength(1:(jj-1)))+kk+1)=-1;
        end
    end
