function [bwCAll, mask, bwSum, polyA, CC] = fun_getCC(cont, M, N)

nC = length(cont);
bwCAll = cell(nC, 1);
mask = false(M, N, nC);
bwSum = zeros(M, N);
CC = cell(nC, 1);
polyA = zeros(nC, 2);

for iC = 1:nC
    C = cont{iC};
    if ~isempty(C)
        bwC = false(N, M);  % original orientation
        for n = 1:size(C, 1)
            bwC(C(n, 2), C(n, 1)) = 1;
        end
        
        bwC = rot90(bwC, 3);  % rotate cw 90
        
        bwCAll{iC} = bwC;

        B = bwboundaries(bwC);
        for n = 1:length(B)
            pA(n) = polyarea(B{n}(:, 1), B{n}(:, 2));
        end

        [polyA(iC, 1), idx] = max(pA);
        polyA(iC, 2) = length(B);
        CC{iC} = B{idx};

        mask(:,:,iC) = poly2mask(CC{iC}(:, 2), CC{iC}(:, 1), M, N);
        bwSum = bwSum+mask(:,:,iC);
    end
end