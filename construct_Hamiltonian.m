% function Ho = construct_Hamiltonian(t, U, N)
% The function construct the hamilotnian
% Input
% t = hopping term 
% U = strength of interaction
% N = Number of sites
% Output
% H = the Hamiltonian for either a spinless fermion or a tight bind.
% E = Eigenvalues / Energies
% Psi = wavefunction
%     Ho = 0;
%     
% %     t = eye(2^N); % the hopping term can be given as a matrix(must be symmetric)
%    % t = 1; % the hoppping term can calso be a constant
%     for k = 1:N-1
%         if U == 0 
%             Ho = Ho -t*(creation_op(k,N) * annihilate_op(k+1,N))+ (-t*( annihilate_op(k,N)*(creation_op(k+1,N))));
%         else
%             Ho =Ho -t*(creation_op(k,N) * annihilate_op(k+1,N))+ (-t*(creation_op(k+1,N) * annihilate_op(k,N)))+  ...
%              + U*(num_op(k,N)*num_op(k+1,N));
%         end
%     end
% end

function Ho = construct_Hamiltonian(t, U, N)
    % Constructing a tridiagonal hopping matrix
    t_mat = diag(t * ones(1, N-1), 1) + diag(t * ones(1, N-1), -1);
    
    Ho = 0;
    for k = 1:N-1
        if U == 0
            Ho = Ho + (t_mat(k, k+1) * ((creation_op(k, N) * annihilate_op(k+1, N) + creation_op(k+1, N) * annihilate_op(k, N))));
        else
            Ho = Ho + t_mat(k, k+1) * (creation_op(k, N) * annihilate_op(k+1, N) + creation_op(k+1, N) * annihilate_op(k, N)) ...
                 + U * (num_op(k, N) * num_op(k+1, N));
        end
    end
end

% function Ho = construct_Hamiltonian(t, N)  %open boundary conditions
%     % Initializing the Hamiltonian as an N by N matrix.
%     Ho = zeros(N, N);
%     
%     % Loop over each site to fill in the hopping terms.
%     for k = 1:N-1 % For open boundary conditions, we have N-1 hopping terms.
%         % Define the neighboring site.
%         nextSite = k + 1;
%         
%         % Fill in the Hamiltonian with the hopping term.
%         Ho(k, nextSite) = -t;
%         Ho(nextSite, k) = -t; % Hamiltonian is Hermitian
%     end
% end



% function Ho = construct_Hamiltonian(t, N) %periodic boundary conditions
%     % Initializing the Hamiltonian as an N by N matrix.
%     Ho = zeros(N, N);
%     
%     % Loop over each site to fill in the hopping terms.
%     for k = 1:N
%         % Define the neighboring site with periodic boundary conditions.
%         nextSite = mod(k, N) + 1;
%         
%         % Fill in the Hamiltonian with the hopping term.
%         Ho(k, nextSite) = -t;
%         Ho(nextSite, k) = -t; % Hamiltonian is Hermitian
%     end
% end
% 




% function Ho = construct_Hamiltonian(t, N)
%     % construct_Hamiltonian constructs the Hamiltonian for the 
%     % non-interacting tight-binding model with periodic boundary conditions.
%     %
%     % Args:
%     %   t: Hopping parameter
%     %   N: Number of lattice sites
%     %
%     % Returns:
%     %   Ho: Hamiltonian matrix of the system in the computational basis
%     
%     % Initialize the Hamiltonian matrix as a zero matrix.
%     % The size of the matrix is 2^N x 2^N, where N is the number of lattice sites.
%     % Each row and column represents a possible state of the system.
%     Ho = zeros(2^N, 2^N);
%     
%     % Loop over all possible states of the system. 
%     % Each state is represented by an integer between 0 and (2^N - 1).
%     for state = 0:(2^N - 1)
%         
%         % Convert the decimal representation of the state to a binary string
%         % of length N, where each bit represents the occupation number
%         % at the corresponding lattice site (0 for unoccupied, 1 for occupied).
%         stateBinary = dec2bin(state, N) == '1';
%         
%         % Loop over each site in the system to check for possible hopping events.
%         for k = 1:N
%             % Calculate the index of the neighboring site with periodic boundary conditions.
%             % If k is the last site, kp1 will be 1; otherwise, it will be k + 1.
%             kp1 = mod(k, N) + 1;
%             
%             % Check the occupation number at sites k and kp1.
%             % If site k is occupied and site kp1 is unoccupied, hopping is possible.
%             if stateBinary(k) && ~stateBinary(kp1)
%                 
%                 % Create a new state where the particle hops from site k to site kp1.
%                 newStateBinary = stateBinary;
%                 newStateBinary(k) = false;
%                 newStateBinary(kp1) = true;
%                 
%                 % Convert the binary representation of the new state back to decimal.
%                 newState = bin2dec(char(newStateBinary + '0'));
%                 
%                 % Update the Hamiltonian matrix elements corresponding to the 
%                 % initial and final states due to the hopping event.
%                 Ho(state + 1, newState + 1) = -t;
%                 Ho(newState + 1, state + 1) = -t;
%             end
%         end
%     end
% end
% 
% 
% 
