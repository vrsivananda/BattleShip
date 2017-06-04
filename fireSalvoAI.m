function [updated_shipBoardH, updated_guessBoardAI, nShotsH] = fireSalvoAI(shipBoardH, guessBoardAI, nShotsAI)
    
    %Make an internal representation off the guessBoardAI
    shotBoard = guessBoardAI;
    
    %Counter for the number of shots taken
    shotCounter = 0;
    
    shipsLeft = shipsLeft(shipBoardH);
    
    %While there are ships which have been hit but not sunk and the
    %there are still shots left, fire type 2 shots
    while( any(any(any(guessBoardAI == 2))) && shotCounter < nShotsAI )
    
        %If there are ships that have been hit but not been sunk, then fire
        %type 2 shots
        
        shotBoard = fireType2Shots(shotBoard);
        
        
    end
    
    
    
    %Flag for singleShot
    doSingleShot = 1;
    
    %As long as we can still fire a single shot, and we have not fired all
    %our shots, fire the singleShot
    while (doSingleShot && shotCounter < nShotsAI)
        shotBoard = singleShot(shotBoard);
    end

end