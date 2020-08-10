function K = ELstiff (L,b,h,E)        %% Clockwise moment positive and Upward force positive


I = (b * (h^3))/12;
Coeff = [ 12 -6*L -12 -6*L; -6*L 4*(L^2) 6*L 2*(L^2); -12 6*L 12 6*L; -6*L 2*(L^2) 6*L 4*(L^2)];
Const = ( E * I / (L^3) ); 
K = Const * Coeff;
%end 