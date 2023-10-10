clear
clc
% Example script to run the two_site_dmrg function

% Parameters for the Hubbard model
N = 6;             % Number of sites
bd = 2;             % Local space dimension (spin up and spin down)
                    % Bond dimension
U = 0;             % Onsite interaction strength
t = 1;             % Hopping parameter
max_sweeps = 10;   % Maximum number of sweeps
%  tol = 1e-6;        % Convergence tolerance
 NrEl=2;            %Number of elements
mu = 0;


% Run the two_site_dmrg function
[lowest_energy, energy_values, M, E_exact] = two_site_dmrg(N, bd, U, mu, t, NrEl,max_sweeps);

% % % Display the final energy
%  fprintf('Ground state energy: %.6f\n', energy);

