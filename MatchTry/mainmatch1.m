load('table_PointOfMatch.mat');%ģ��
Count=match(thinFP,thinFP1,PointOfModel,PointOfMatch,txy,txy1)
Precision=Count./length(PointOfModel(:,1))
Recall=Count./length(PointOfMatch(:,1))