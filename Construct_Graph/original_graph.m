%% the original category information graph
X = load('twomoon.txt');
mat_label = X;
labels = mat_label(:,3);
la = labels;
figure; 
XX=[X,labels];
%%label different colors according to categories
plot(X(la==1,1),X(la==1,2),'.r', 'MarkerSize', 18); hold on;
plot(X(la==2,1),X(la==2,2),'.k', 'MarkerSize', 18); hold on;
% plot(X(la==3,1),X(la==3,2),'.b', 'MarkerSize', 18); hold on;
% plot(X(la==4,1),X(la==4,2),'.g', 'MarkerSize', 18); hold on;
% plot(X(la==5,1),X(la==5,2),'.c', 'MarkerSize', 18); hold on;
% plot(X(la==6,1),X(la==6,2),'.m', 'MarkerSize', 18); hold on;
% plot(X(la==7,1),X(la==7,2),'.y', 'MarkerSize', 18); hold on;
axis equal;