% function MPO = identity_MPO(N, d)
%     MPO = cell(1, N);  % Cell array to store the tensors
% 
%     for i = 1:N
%         tensor = zeros(4, d, d, 4);
%         for j = 1:d
%             tensor(4, j, j, 4) = 1.0;
%         end
%         MPO{i} = tensor;
%     end
% end


function MPO = identity_MPO(N, d)
    MPO = cell(1, N);  % Cell array to store the tensors

    % First tensor
    tensor = zeros(1, d, d, 4);
    for j = 1:d
        tensor(1, j, j, :) = 1.0;
    end
    MPO{1} = tensor;

    % Intermediate tensors
    for i = 2:N-1
        tensor = zeros(4, d, d, 4);
        for j = 1:d
            tensor(:, j, j, :) = eye(4);  % 4x4 identity for the bond dimension
        end
        MPO{i} = tensor;
    end

    % Last tensor
    if N > 1
        tensor = zeros(4, d, d, 1);
        for j = 1:d
            tensor(:, j, j, 1) = 1.0;
        end
        MPO{N} = tensor;
    end

end

