N_ITERATIONS = 100;
tol = 5e-15;

mu = linspace(0.001,0.5,N_ITERATIONS);

for i=1:N_ITERATIONS
    DF = RTBPdiff(mu(i));
    [v11,L11] = select_eigenvector(mu(i),1,1);
    a11 = DF(L11)*v11;
    if (rank([v11,a11],tol) > 1)
        error('ERROR in TESTER: rank too big.')
    end
    if (a11'*v11 < 0)
        error('ERROR i TESTER: vector not unstable.')
    end
    [v12,L12] = select_eigenvector(mu(i),2,1);
    a12 = DF(L12)*v12;
    if (rank([v12,a12],tol) > 1)
        error('ERROR in TESTER: rank too big.')
    end
    if (a12'*v12 < 0)
        error('ERROR i TESTER: vector not unstable.')
    end
    [v13,L13] = select_eigenvector(mu(i),3,1);
    a13 = DF(L13)*v13;
    if (rank([v13,a13],tol) > 1)
        error('ERROR in TESTER: rank too big.')
    end
    if (a13'*v13 < 0)
        error('ERROR i TESTER: vector not unstable.')
    end
    [v21,L21] = select_eigenvector(mu(i),1,-1);
    a21 = DF(L21)*v21;
    if (rank([v21,a21],tol) > 1)
        error('ERROR in TESTER: rank too big.')
    end
    if (a21'*v21 > 0)
        error('ERROR i TESTER: vector not stable.')
    end
    [v22,L22] = select_eigenvector(mu(i),2,-1);
    a22 = DF(L22)*v22;
    if (rank([v22,a22],tol) > 1)
        error('ERROR in TESTER: rank too big.')
    end
    if (a22'*v22 > 0)
        error('ERROR i TESTER: vector not stable.')
    end
    [v23,L23] = select_eigenvector(mu(i),3,-1);
    a23 = DF(L23)*v23;
    if (rank([v23,a23],tol) > 1)
        error('ERROR in TESTER: rank too big.')
    end
    if (a23'*v23 > 0)
        error('ERROR i TESTER: vector not stable.')
    end
end

clear v11 v12 v13 v21 v22 v23 L11 L12 L13 L21 L22 L23 N_ITERATIONS i mu tol a11 a12 a13 a21 a22 a23