A = [0 1 0; 0 0 1; -1 -5 -6];
B = [0; 0; 1];

cm = ctrb(A,B); % controllability matrix
rank(ctrb(A,B)); % rank of controllability matrix

eig(A); % eigenvalues of A

K = [199 55 8];

A_cl = A - B*K; % closed-loop system matrix
eig(A_cl) % eigenvalues of closed-loop system

W = [ 5 6 1;
      6  1 0;
     1  0 0];

T = cm*W; % transformation matrix

K = [199 55 8]*inv(T); % state feedback gain in transformed coordinates


phi_A = A^3 + 14*A^2 + 60*A + 200*eye(3);

K = [0 0 1]*inv(cm)*phi_A; % using desired characteristic polynomial