function app = repTable(app, sol, NameCollection)

input=[];

app.UITable.Data...
                =[int8(sol(860)) int8(sol(861))...
                int8(sol(863)) int8(sol(864))...
                int8(sum(sol(867:871))) int8(sol(875)) int8(sol(876)) int8(sol(882))];
            [row,col]=find(sol>0.1);
            app.UITable2.Data...
                =[NameCollection(row(1));NameCollection(row(2));...
                NameCollection(row(3));NameCollection(row(4));...
                NameCollection(row(5));NameCollection(row(6))];
            %input = readcell('ability_data/custom');
            load('ability_data/custom.mat');
            [row,col]=find(sol(933:948)>0.1);
            view=[];
            for ii=1:size(row)
                view = [view;string(input{row(ii)+1,1})];
            end
            app.UITable3.Data=view;
            %input = readcell('ability_data/awake');
            load('ability_data/awake.mat');
            [row,col]=find(sol(949:976)>0.1);
            view=[];
            for ii=1:size(row)
                for jj=1:int8(sol(949+row(ii)-1))
                view = [view;string(input{row(ii)+1,1})];
                end
            end
            %input = readcell('ability_data/seriesskills');
            load('ability_data/skillMat');
            input=ExtractedSeriesSkills;
            [row,col]=find(sol(977:982)>0.1);
            if size(row)>=1
                view = [view;string(input{row(1),1})];
            end
            app.UITable4.Data=view;
            
            [row,col]=find(int8(sol(711:859))>0.1);
            deco=[];
            for ii=1:size(row)
                deco = [deco;[NameCollection(711-1+row(ii)) sol(711-1+row(ii))]];
            end
            app.UITable5.Data=deco;
            
            app.Label_14.Text=string(int8(sol(873)));
            app.Label_15.Text=string(int8(sol(874)));
            app.Label_16.Text=string(int8(sol(884)));
            app.Label_17.Text=string(int8(sol(862)));
            app.Label_18.Text=string(int8(sol(880)));
