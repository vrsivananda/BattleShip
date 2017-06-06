function [numSunk]=sunkShipCounter(board)

[rows,cols,depth]=size(board);

% look for 3 sheet by sheet
for dep=1:depth
    for row=1:rows
        for col=1:cols
            if board(row,col,dep)==3
                if board(row,col+1,dep)
    
