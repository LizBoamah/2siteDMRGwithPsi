function H = build_H_from_W(MPO,t)
    N = length(MPO);
    dimH = 2^N;
    H = zeros(dimH);
    t = 1; % replace with your value
    
    for row = 1:dimH
        for col = 1:dimH
            coeff = 1;
            state_row = dec2bin(row - 1, N) - '0' + 1;
            state_col = dec2bin(col - 1, N) - '0' + 1;
            
            for site = 1:N
                W = MPO{site};
                row_site = state_row(site);
                col_site = state_col(site);
                
                if site == 1
                    coeff = coeff * W(1, row_site, col_site, 4);
                elseif site == N
                    coeff = coeff * W(4, row_site, col_site, 1);
                else
                    coeff = coeff * W(4, row_site, col_site, 4);
                end
                
                if site < N % ensure we're not at the last site
                    W_next = MPO{site + 1}; % get the W tensor at the next site
                    next_site_state_row = state_row(site + 1);
                    next_site_state_col = state_col(site + 1);
                    
                    if size(W_next, 1) > 1 % check if W_next has a second index
                        % replace with your correct indices to access hopping terms
                        hopping_coeff = -t * (W(2, row_site, next_site_state_col, 4) + W_next(3, next_site_state_row, col_site, 4));
                        coeff = coeff * hopping_coeff;
                    end
                end
            end
            
            H(row, col) = coeff;
        end
    end
end
