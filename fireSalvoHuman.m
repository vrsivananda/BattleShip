function [updated_shipBoardAI, updated_guessBoardH, nShotsAI] = fireSalvoHuman(shipBoardAI, guessBoardH, nShotsH)

nShotsH=5;

% create an empty variable storing firePositions
firePos=[];

% create an var storing the # shots left
shotsLeft=nShotsH;

% while having shots left, prompt user for coordinates for shooting pos
while (shotsLeft>0)
    
    % the inputPos will be a string
    inputPos=input('Where to fire? (e.g.[3 2 1]): ');
    % add the inputPosVec to the new row of firePos the matrix
    firePos(size(firePos,1)+1,:)=inputPos;
    shotsLeft=shotsLeft-1;
    
end % end of while loop

% loop through all the firePos coordinates and update guessBoardH and
% shipBoardAI
for n=1:size(firePos,1)
    
    % get the coordinate
    theFirePos=firePos(n,:);
    % get row, col and depth of the coordinate
    row=theFirePos(1);
    col=theFirePos(2);
    depth=theFirePos(3);
    
    % check the value of fire position on enemy's shipBoard
    
    % check if it is an empty space
    if shipBoardAI(row,col,depth)==0;
        disp('Miss :(');
        % update the fired empty space on shipBoardAI
        shipBoardAI(row,col,depth)=-1;
        % update the fired empty space on guessBoardH
        guessBoardH(row,col,depth)=-1;
    % check if it contains a ship
    elseif shipBoardAI(row,col,depth)==1;
        disp('Hits! :)');
        % update the fired ship space on shipBoardAI
        shipBoardAI(row,col,depth)=2;
        % update the fired ship space on guessBoardH
        guessBoardH(row,col,depth)=2;
    % check if it is a fired empty space
    elseif (shipBoardAI(row,col,depth) == -1)
    %disp(fired at -1 spot)
    disp('Fired in a position of a fired empty spot. Redundant firing.');
    % check if it fires in a position of a fired ship 
    elseif (shipBoardAI(row,col,depth) == 2)
    %disp(fired at 2 spot)
    disp('Fired in a position of a fired ship. Redundant firing.');
    % else if fired in a position of sunk ship
    elseif (shipBoardAI(row,col,depth) == 3)
    %disp(fired at a sunk ship region)
    disp('Fired in a sunk ship region. Redundant firing.');
    end % end of if conditions
end % end of for loop 

% updated shipBoardAI
updated_shipBoardAI=shipBoardAI;
% updated guessBoardH
updated_guessBoardH=guessBoardH;

% sunk ship region (set value to 3)

% sunk ship counter function


% update nShotsAI
nShotsAI=nShotsH-sunkShips;

end


