clc
clear all
NDF = 2;                                    %NDF = No. of DOF of each node
NPE = 2;                                    %NPE = No. of nodes per element
NEM = 2;                                    %NEM = No. of elements
L = 0.6;                                      %L = length of element
b = 0.02;                                      %b = breadth of element
h = 0.02;                                      %h = depth or height of element
ele_L = L/NEM;
LDOF = NDF * NPE;                           %LDOF = Local Degrees of Freedom
GDOF = LDOF + NDF * (NEM - 1);              %GDOF = Global Degrees of Freedom
E = 69 * 1e9;                              %E = young's modulus of steel in N/m^2
Gstiff = zeros(GDOF);
I = (b * (h^3))/12;
for Ele=1:NEM
    p = NDF * (Ele - 1);
    Ke = ELstiff(ele_L,b,h,E);
    for i=1:LDOF
        
        for j=1:LDOF
            
              Gstiff(i+p,j+p) = Gstiff(i+p,j+p) + Ke(i,j);
              
        end
        
    end
end

%% Boundary Conditions for cantilever beam
Lock_node = 1;                          %the node number which is locked
Lock_DOF = 2;
q = (2 * Lock_node) - 1;
w = GDOF - Lock_DOF;
%Global_stiff = Gstiff;
for i=1:w
    k = i + 2;
    
    
    for j=1:w
        l = j + 2;
        
        Global_stiff(i,j) = Gstiff(k,l);
        
    end
    
end

%% Displacement solution
For_vec = zeros(w,1);
For_vec(2*NEM - 1) = 1;
G = inv(Global_stiff);
Disp = G * For_vec;
for i = 1:NEM
   
Defl(i,1) = Disp(2*i-1,1);
Defl(i,2) = Disp(2*i,1);
end
verify_disp = L^3 / (3 * E * I);
verify_rot = L^2 / (2 * E * I);









    