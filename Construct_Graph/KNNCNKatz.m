function [KCK]=KNNCNKatz(X,knn_num_neighbors)
    E= buildGraph(X, 5);
    W=E;
    W(W==0.2)=1;
    W=W-eye(size(W,1));
    p1= sum(sum(W==W'))==numel(W) %判断是否是对称矩阵
    W=triu(W) ;
    W=W+W';
    p2= sum(sum(W==W'))==numel(W);
    EE=W;
    num0 = 100;
    y0 = [ones(num0,1);2*ones(num0,1)];
    la=y0;
    K = inv( sparse(eye(size(EE,1))) - 0.2 * EE);
    k=round(size(K,1)*0.01);
    t2= MatrixTopk( K,k );
    C = EE* EE;
    k=round(size(C,1)*0.01);
    t1= MatrixTopk( C,k );


%% FLG(knn+cn+Katz)
    %KCK=zeros(size(W,1));
    KCK=W+t1+t2;
    KCK(KCK~=0)=1;%将矩阵中非零值赋为1

    figure;
    plot(X(:,1),X(:,2),'.k', 'MarkerSize', 18); hold on;
    plot(X(la==1,1),X(la==1,2),'.r', 'MarkerSize', 18); hold on;
    plot(X(la==2,1),X(la==2,2),'.', 'MarkerSize', 18); hold on;
    title('Graph KNN+CN+Katz');
    nn = 2*num0;
    for ii = 1 : nn
        for jj = 1 : ii
            weight = KCK(ii, jj);
            if weight > 0
                plot([X(ii, 1), X(jj, 1)], [X(ii, 2), X(jj, 2)], '-g', 'LineWidth', 1), hold on;
            end
        end;
    end;
    axis equal;