function [updated_shipBoardAI, updated_guessBoardH, nShotsAI] = fireSalvoHuman(shipBoardAI, guessBoardH, nShotsH)

% testing

%  shipBoardAI(:,:,1)=[1,1,1,0,0;0,0,0,1,0;0,0,0,0,0;0,0,0,0,0];
%  shipBoardAI(:,:,2)=[0,0,0,0,0;0,0,0,1,0;0,1,0,0,0;0,1,0,0,0];
%  shipBoardAI(:,:,3)=[0,0,0,0,0;0,0,0,1,0;0,0,0,0,0;0,0,0,0,0];
%  
%  guessBoardH(:,:,1)=[0,0,0,0,0;0,0,0,0,0;0,0,0,0,0;0,0,0,0,0];
%  guessBoardH(:,:,2)=[0,0,0,0,0;0,0,0,0,0;0,0,0,0,0;0,0,0,0,0];
%  guessBoardH(:,:,3)=[0,0,0,0,0;0,0,0,0,0;0,0,0,0,0;0,0,0,0,0];
%  
%  nShotsH=2;

% end of testing

% check for inputs %

%Get the dimensions of the board
rows = size(guessBoardH,1);
cols = size(guessBoardH,2);
sheets = size(guessBoardH,3);


% create an empty variable storing firePositions
firePos=[];

% create an var storing the # shots left
shotsLeft=nShotsH;

% while having shots left, prompt user for coordinates for shooting pos
while (shotsLeft>0)
    
    %Flag for a redo in case entry is inappropriate
    redo = true;
    while (redo == true)
        % the inputPos will be a string
        inputPos=input('Where to fire? (e.g.[3 2 1]): ');

        % check for inputs
        % error msgs
         %Make sure it is a matrix, has 1 row, and 3 columns
            if(~ismatrix(inputPos) || size(inputPos,1) ~= 1 || size(inputPos,2) ~= 3)
                disp('---> Dimensions are not right. Please try again.');
                %redo the while loop and ask again
                continue;
            %Check that all the values entered are within the scope of the
            %board
            elseif(inputPos(1) < 1 || inputPos(1) > rows || inputPos(2) < 1 || inputPos(2) > cols || inputPos(3) < 1 || inputPos(3) > sheets)
                %If they are not, then redo the while loop and ask again
                disp('---> Location is outside board. Please choose again.');
                continue;
            %Check that the space is indeed available on the board
            elseif(guessBoardH(inputPos(1),inputPos(2),inputPos(3)) ~= 0 )
                %If it is not, then redo the while loop and ask again
                disp('---> Location has been fired upon previously. Please choose again.');
                continue;
            else
                redo = false;
            end
    end %end of inner while loop
    
    % add the inputPosVec to the new row of firePos the matrix
    firePos(size(firePos,1)+1,:)=inputPos;
    if size(unique(firePos,'rows'),1) == size(firePos,1)
        shotsLeft=shotsLeft-1;
    else
        firePos = unique(firePos,'rows');
        disp('---> Location has been fired upon previously. Please choose again.');
    end
    
    
end % end of outer while loop

% loop through all the firePos coordinates and update guessBoardH and
% shipBoardAI
for n=1:size(firePos,1)
    
    % get the coordinate
    theFirePos=firePos(n,:);
    % get row, col and depth of the coordinate
    row = theFirePos(1);
    col = theFirePos(2);
    depth = theFirePos(3);
    
    % check the value of fire position on enemy's shipBoard
    
    % check if it is an empty space
    if shipBoardAI(row,col,depth)==0
        disp('Miss :(');
        % update the fired empty space on shipBoardAI
        shipBoardAI(row,col,depth)=-1;
        % update the fired empty space on guessBoardH
        guessBoardH(row,col,depth)=-1;
    % check if it contains a ship
    elseif shipBoardAI(row,col,depth)==1
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
[updated_shipBoardAI,updated_guessBoardH]=sinkShips(updated_shipBoardAI,updated_guessBoardH);

% sunk ship counter function
%sunkShips=sunkShipCounter(updated_shipBoardAI);

% update nShotsAI
%nShotsAI=nShotsH-sunkShips;
nShotsAI = length(shipsLeft(updated_shipBoardAI));

end


