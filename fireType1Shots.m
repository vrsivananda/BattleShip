function type1ShotsStore = fireType1Shots(guessBoardAI, nShotsAI, shotCounter, type2ShotsStore, minShipLength)
%The technical random shot when no hits are indicated

%Declare variable to keep track of shots left
nShotsLeft = nShotsAI - shotCounter;

%Declare a storage to store type1 shots
type1ShotsStore = [];

%Represent the board with type2 shots done

for i=1:size(type2ShotsStore,1)
    ShotBoard = guessBoardAI;
    ShotBoard(type2ShotsStore(i,:)) = 5;
end

while nShotsLeft > 0
    [ShotBoard, currentshotLocation] = singleShot(ShotBoard,minShipLength);
    type1ShotsStore(size(type1ShotsStore,1)+1,:) = currentshotLocation;
    nShotsLeft = nShotsLeft - 1;
end

end % End of function



