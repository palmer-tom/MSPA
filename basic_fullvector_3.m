% This example shows how to calculate and plot both the
% fundamental TE and TM eigenmodes of an example 3-layer ridge
% waveguide using the full-vector eigenmode solver.  

clear
clc

% Refractive indices:
n1 = 3.34;                      % Lower cladding
n2 = linspace(3.305,3.44,10);   % Core
n3 = 1.00;                      % Upper cladding (air)

% Layer heights:
h1 = 2.0;           % Lower cladding
h2 = 1.3;           % Core thickness
h3 = 0.5;           % Upper cladding

% Horizontal dimensions:
rh = 1.1;           % Ridge height
rw = 1.0;           % Ridge half-width
side = 1.5;         % Space on side

% Grid size:
dx = 0.0125;        % grid size (horizontal)
dy = 0.0125;        % grid size (vertical)

lambda = 1.55;      % vacuum wavelength
nmodes = 1;         % number of modes to compute

[x,y,xc,yc,nx,ny,eps,edges] = waveguidemesh([n1,n2,n3],[h1,h2,h3], ...
                                            rh,rw,side,dx,dy); 
neff_vect = zeros(1,10);

for n = 1:10

    [Hx,Hy,neff] = wgmodes(lambda,n2(n),nmodes,dx,dy,eps,'000A');

    neff_vect(1,n) = neff;
    
    fprintf(1,'neff = %.6f\n',neff);

    figure(1);
    subplot(121);
    %contourmode(x,y,Hx(:,:,n));
    surf(real(Hx(:,:,1)));
    title('Hx (TE mode)'); xlabel('x'); ylabel('y'); 
    for v = edges, line(v{:}); end

    subplot(122);
    %contourmode(x,y,Hy(:,:,n));
    surf(real(Hy(:,:,1)));
    title('Hy (TE mode)'); xlabel('x'); ylabel('y'); 
    for v = edges, line(v{:}); end
    pause(1)
end

figure(2)
plot(n2,neff_vect(1,:))
title('Effect of Ridge Index on N_{eff}')
xlabel('Ridge Index')
ylabel('N_{eff}')
