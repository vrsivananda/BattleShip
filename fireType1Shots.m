function type1ShotsStore = fireType1Shots(guessBoardAI, nShotsAI, shotCounter, type2ShotsStore, minShipLength)
%The technical random shot when no hits are indicated

    %Declare variable to keep track of shots left
    nShotsLeft = nShotsAI - shotCounter;

    %Declare a storage to store type1 shots
    type1ShotsStore = [];

    %Declare ShotBoard in case there are no type2 shots
    ShotBoard = guessBoardAI;

    %Represent the board with type2 shots done
    for i=1:size(type2ShotsStore,1)
        ShotBoard = guessBoardAI;
        ShotBoard(type2ShotsStore(i,:)) = 5;
    end

    %Fire type1 shots with all rest shots
    while nShotsLeft > 0
        [ShotBoard, currentshotLocation] = singleShot(ShotBoard,minShipLength);
        type1ShotsStore(size(type1ShotsStore,1)+1,:) = currentshotLocation;
        if size(unique(type2ShotsStore,'rows'),1) == size(type2ShotsStore,1)
            nShotsLeft = nShotsLeft - 1;
        else
            type2ShotsStore = unique(type2ShotsStore,'rows');
        end
    end

end % End of function



