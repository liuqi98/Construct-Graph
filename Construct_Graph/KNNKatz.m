function [KK]=KNNKatz(X,knn_num_neighbors)
    E= buildGraph(X, knn_num_neighbors);
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
        %% knn基础上进行Katz预测，画出Katz
    %Katz:进行局部链路预测，得到图G2
    K = inv( sparse(eye(size(EE,1))) - 0.2 * EE);
    k=round(size(K,1)*0.01);
    t2= MatrixTopk( K,k );

    figure;
    plot(X(:,1),X(:,2),'.k', 'MarkerSize', 18); hold on;
    plot(X(la==1,1),X(la==1,2),'.r', 'MarkerSize', 18); hold on;
    plot(X(la==2,1),X(la==2,2),'.', 'MarkerSize', 18); hold on;
    title('Graph Katz');
    nn = 2*num0;
    for ii = 1 : nn
        for jj = 1 : ii
            weight = t2(ii, jj);
            if weight > 0
                % plot([X(ii, 1), X(jj, 1)], [X(ii, 2), X(jj, 2)], '-g', 'LineWidth', 15*weight), hold on;
                plot([X(ii, 1), X(jj, 1)], [X(ii, 2), X(jj, 2)], '-g', 'LineWidth', 1), hold on;
            end
        end;
    end;
    axis equal;
    %% knn+Katz
    KK=zeros(size(W,1));
    KK=W+t2;
    KK(KK~=0)=1;%将矩阵中非零值赋为1

    figure;
    plot(X(:,1),X(:,2),'.k', 'MarkerSize', 18); hold on;
    plot(X(la==1,1),X(la==1,2),'.r', 'MarkerSize', 18); hold on;
    plot(X(la==2,1),X(la==2,2),'.', 'MarkerSize', 18); hold on;
    title('Graph knn+Katz');
    nn = 2*num0;
    for ii = 1 : nn
        for jj = 1 : ii
            weight = KK(ii, jj);
            if weight > 0
                % plot([X(ii, 1), X(jj, 1)], [X(ii, 2), X(jj, 2)], '-g', 'LineWidth', 15*weight), hold on;
                plot([X(ii, 1), X(jj, 1)], [X(ii, 2), X(jj, 2)], '-g', 'LineWidth', 1), hold on;
            end
        end;
    end;
    axis equal;
end
