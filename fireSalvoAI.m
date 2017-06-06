function [updated_shipBoardH, updated_guessBoardAI, nShotsH] = fireSalvoAI(shipBoardH, guessBoardAI, nShotsAI)
%     
%     %Make a copy of the boards to be an updated board later
%     updated_shipBoardH = shipBoardH;
%     updated_guessBoardAI = guessBoardAI;

    %Make an internal representation off the guessBoardAI
    shotBoard = guessBoardAI;
    
    %Counter for the number of shots taken
    shotCounter = 0;
    
    shipsLeftVector = shipsLeft(shipBoardH);
    nshipsLeft = length(shipsLeftVector);
    minShipLength = min(shipsLeftVector);
    
    %----------Type 2 Shots---------
    %If there are ships which have been hit but not sunk and the
    %there are still shots left, fire type 2 shots
    if ( any(any(any(guessBoardAI == 2))) && shotCounter < nShotsAI )
        %A matrix of shots are returned
        type2ShotsStore = fireType2Shots(shotBoard, nShotsAI, minShipLength);
        %Increment the shotCounter based on how many type2 shots are fired
        shotCounter = shotCounter + size(type2ShotsStore,1);
    end
    
    %----------Type 1 Shots---------
    
    %As long as we can still fire a single shot, and we have not fired all
    %our shots, fire the singleShot
    type1ShotsStore = fireType1Shots(guessBoardAI, nShotsAI,shotCounter, type2ShotsStore, minShipLength);
    
    %----------Update shipBoardH and guessBoardAI---------
    %Go through the shots store one by one and match with both boards
    %(update accordingly)
    
    %Merge both the type1 and type2 shot stores
    bothShotsStore = [type2ShotsStore; type1ShotsStore];
    
    %for each row of shotsStore
    for i = 1:size(bothShotsStore,1)
        % check if the location on shipBoardH is an unhit ship (1)
        if(shipBoardH(bothShotsStore(i,:)) == 1)
            % update shipBoardH to (2)
            shipBoardH(bothShotsStore(i,:)) = 2; 
            % update guessBoardAI to (2)
            guessBoardAI(bothShotsStore(i,:)) = 2; 
        % else if empty(0)
        elseif (shipBoardH(bothShotsStore(i,:)) == 0)
            %update shipBoardH to (-1)
            shipBoardH(bothShotsStore(i,:)) = -1; 
            % update guessBoardAI to (-1)
            guessBoardAI(bothShotsStore(i,:)) = -1; 
        % else if (-1)
        elseif (shipBoardH(bothShotsStore(i,:)) == -1)
            %disp(fired at -1 spot)
            disp('Fired in a -1 spot. Redundant firing.');
        % else if (2)
        elseif (shipBoardH(bothShotsStore(i,:)) == 2)
            %disp(fired at 2 spot)
            disp('Fired in a 2 spot. Redundant firing.');
        % else if (3)
        elseif (shipBoardH(bothShotsStore(i,:)) == 3)
            %disp(fired at 3 spot)
            disp('Fired in a 3 spot. Redundant firing.');
        end
    end %end of for loop
    
    %----------Sink the ships if any---------
    %Sink the ships on both boards
    [shipBoardH, guessBoardAI] = sinkShips(shipBoardH, guessBoardAI);
    
    
    %----------Calculate the number of shots left---------
    
end