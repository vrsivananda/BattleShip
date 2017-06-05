function [updated_shipBoardH, updated_guessBoardAI, nShotsH] = fireSalvoAI(shipBoardH, guessBoardAI, nShotsAI)
    
    %Make an internal representation off the guessBoardAI
    shotBoard = guessBoardAI;
    
    %Counter for the number of shots taken
    shotCounter = 0;
    
    shipsLeftVector = shipsLeft(shipBoardH);
    nshipsLeft = length(shipsLeftVector);
    
    %If there are ships which have been hit but not sunk and the
    %there are still shots left, fire type 2 shots
    if ( any(any(any(guessBoardAI == 2))) && shotCounter < nShotsAI )
        %A matrix of shots are returned
        type2ShotsStore = fireType2Shots(shotBoard, nShotsAI, min(shipsLeftVector));
        %Increment the shotCounter based on how many type2 shots are fired
        shotCounter = shotCounter + size(type2ShotsStore,1);
    end
    
    %Flag for singleShot
    doSingleShot = 1;
    
    %As long as we can still fire a single shot, and we have not fired all
    %our shots, fire the singleShot
    while (doSingleShot && shotCounter < nShotsAI)
        shotBoard = singleShot(shotBoard);
    end

end