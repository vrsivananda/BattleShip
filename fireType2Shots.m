function uniqueType2ShotsStore = fireType2Shots(guessBoardAI, nShotsAI, minShipLength)

%Declare variable to keep track of shots left
nShotsLeft = nShotsAI;

%Declare a storage to store type2 shots
type2ShotsStore = [];

%Get the max dimensions to avoid going off board
[maxRows, maxCols, maxSheets] = size(guessBoardAI);

%Loop through all the dimensions to find the existing hit.
for k = 1:maxSheets
    for j = 1: maxCols
        for i = 1:maxRows
            %If the box is hit but ship is not yet sunk
            if (guessBoardAI(i,j,k) == 2)
                
                %Declare boolean variables to indicate which sides are
                %hit
                
                %check if any sides are hit
                
                %--------------------
                %(1)
                %check top
                if (i-1 > 1 && guessBoardAI(i-1,j,k) == 2)
                    
                    %Block the original location to avoid double-counting
                    %guessBoardAI(i,j,k) = 5;
                    
                    topCounter = 1;
                    %Keep checking up until it runs out of board or is
                    %not a hit anymore
                    while(i-topCounter >= 1 && guessBoardAI(i-topCounter,j,k) == 2)
                        topCounter = topCounter + 1;
                    end
                    %Declare a shots fired counter to make sure that we
                    %only fire up to the min length ship
                    shotsFiredCounter = 0;
                    %Once it hits an empty spot (0), then start shooting
                    %Keep shooting while it is in the board, it is an
                    %empty spot, and there are still shots left, and we
                    %only shoot up to the min ship length to not waste
                    %shots (in case boards are huge)
                    while (i-topCounter >= 1 && guessBoardAI(i-topCounter,j,k) == 0 && nShotsLeft > 0 && shotsFiredCounter <= ceil((minShipLength-1)/2))
                        %Block the location to avoid double-shooting
                        guessBoardAI(i-topCounter,j,k) = 5;
                        
                        %Store the shot in the shots store
                        type2ShotsStore(size(type2ShotsStore,1)+1,:) = [i-topCounter,j,k];
                        %Decrement the number of shots left
                        nShotsLeft = nShotsLeft - 1;
                        %Increment the counter
                        topCounter = topCounter + 1;
                        %Increment the shotsFiredCounter
                        shotsFiredCounter = shotsFiredCounter + 1;
                    end
                end
                %--------------------
                %(2)
                %check bottom
                if (i+1 < maxRows && guessBoardAI(i+1,j,k) == 2)
                    
                    %Block the original location to avoid double-counting
                    %guessBoardAI(i,j,k) = 5;
                    
                    bottomCounter = 1;
                    %Keep checking up until it runs out of board or is
                    %not a hit anymore
                    while(i+bottomCounter <= maxRows && guessBoardAI(i+bottomCounter,j,k) == 2)
                        bottomCounter = bottomCounter + 1;
                    end
                    %Declare a shots fired counter to make sure that we
                    %only fire up to the min length ship
                    shotsFiredCounter = 0;
                    %Once it hits an empty spot (0), then start shooting
                    %Keep shooting while it is in the board, it is an
                    %empty spot, and there are still shots left, and we
                    %only shoot up to the min ship length to not waste
                    %shots (in case boards are huge)
                    while (i+bottomCounter<= maxRows && guessBoardAI(i+bottomCounter,j,k) == 0 && nShotsLeft > 0 && shotsFiredCounter <= ceil((minShipLength-1)/2))
                        %Block the location to avoid double-shooting
                        guessBoardAI(i+bottomCounter,j,k) = 5;
                        
                        %Store the shot in the shots store
                        type2ShotsStore(size(type2ShotsStore,1)+1,:) = [i+bottomCounter,j,k];
                        %Decrement the number of shots left
                        nShotsLeft = nShotsLeft - 1;
                        %Increment the counter
                        bottomCounter = bottomCounter + 1;
                        %Increment the shotsFiredCounter
                        shotsFiredCounter = shotsFiredCounter + 1;
                    end
                end
                %--------------------
                %(3)
                %check left
                if (j-1 > 1 && guessBoardAI(i,j-1,k) == 2)
                    
                    %Block the original location to avoid double-counting
                    %guessBoardAI(i,j,k) = 5;
                    
                    leftCounter = 1;
                    %Keep checking up until it runs out of board or is
                    %not a hit anymore
                    while(j-leftCounter >= 1 && guessBoardAI(i,j-leftCounter,k) == 2)
                        leftCounter = leftCounter + 1;
                    end
                    %Declare a shots fired counter to make sure that we
                    %only fire up to the min length ship
                    shotsFiredCounter = 0;
                    %Once it hits an empty spot (0), then start shooting
                    %Keep shooting while it is in the board, it is an
                    %empty spot, and there are still shots left, and we
                    %only shoot up to the min ship length to not waste
                    %shots (in case boards are huge)
                    while (j-leftCounter >= 1 && guessBoardAI(i,j-leftCounter,k) == 0 && nShotsLeft > 0 && shotsFiredCounter <= ceil((minShipLength-1)/2))
                        %Block the location to avoid double-shooting
                        guessBoardAI(i,j-leftCounter,k) = 5;
                        
                        %Store the shot in the shots store
                        type2ShotsStore(size(type2ShotsStore,1)+1,:) = [i,j-leftCounter,k];
                        %Decrement the number of shots left
                        nShotsLeft = nShotsLeft - 1;
                        %Increment the counter
                        leftCounter = leftCounter + 1;
                        %Increment the shotsFiredCounter
                        shotsFiredCounter = shotsFiredCounter + 1;
                    end
                end
                %--------------------
                %(4)
                %check right
                if (j+1 < maxCols && guessBoardAI(i,j+1,k) == 2)
                    
                    %Block the original location to avoid double-counting
                    %guessBoardAI(i,j,k) = 5;
                    
                    rightCounter = 1;
                    %Keep checking up until it runs out of board or is
                    %not a hit anymore
                    while(j+rightCounter <= maxCols && guessBoardAI(i,j+rightCounter,k) == 2)
                        rightCounter = rightCounter + 1;
                    end
                    %Declare a shots fired counter to make sure that we
                    %only fire up to the min length ship
                    shotsFiredCounter = 0;
                    %Once it hits an empty spot (0), then start shooting
                    %Keep shooting while it is in the board, it is an
                    %empty spot, and there are still shots left, and we
                    %only shoot up to the min ship length to not waste
                    %shots (in case boards are huge)
                    while (j+rightCounter<= maxCols && guessBoardAI(i,j+rightCounter,k) == 0 && nShotsLeft > 0 && shotsFiredCounter <= ceil((minShipLength-1)/2))
                        %Block the location to avoid double-shooting
                        guessBoardAI(i,j+rightCounter,k) = 5;
                        
                        %Store the shot in the shots store
                        type2ShotsStore(size(type2ShotsStore,1)+1,:) = [i,j+rightCounter,k];
                        %Decrement the number of shots left
                        nShotsLeft = nShotsLeft - 1;
                        %Increment the counter
                        rightCounter = rightCounter + 1;
                        %Increment the shotsFiredCounter
                        shotsFiredCounter = shotsFiredCounter + 1;
                    end
                end
                %--------------------
                %(5)
                %check outer (lower sheets)
                if (k-1 > 1 && guessBoardAI(i,j,k-1) == 2)
                    
                    %Block the original location to avoid double-counting
                    %guessBoardAI(i,j,k) = 5;
                    
                    outerCounter = 1;
                    %Keep checking up until it runs out of board or is
                    %not a hit anymore
                    while(k-outerCounter >= 1 && guessBoardAI(i,j,k-outerCounter) == 2)
                        outerCounter = outerCounter + 1;
                    end
                    %Declare a shots fired counter to make sure that we
                    %only fire up to the min length ship
                    shotsFiredCounter = 0;
                    %Once it hits an empty spot (0), then start shooting
                    %Keep shooting while it is in the board, it is an
                    %empty spot, and there are still shots left, and we
                    %only shoot up to the min ship length to not waste
                    %shots (in case boards are huge)
                    while (k-outerCounter >= 1 && guessBoardAI(i,j,k-outerCounter) == 0 && nShotsLeft > 0 && shotsFiredCounter <= ceil((minShipLength-1)/2))
                        %Block the location to avoid double-shooting
                        guessBoardAI(i,j,k-outerCounter) = 5;
                        
                        %Store the shot in the shots store
                        type2ShotsStore(size(type2ShotsStore,1)+1,:) = [i,j,k-outerCounter];
                        %Decrement the number of shots left
                        nShotsLeft = nShotsLeft - 1;
                        %Increment the counter
                        outerCounter = outerCounter + 1;
                        %Increment the shotsFiredCounter
                        shotsFiredCounter = shotsFiredCounter + 1;
                    end
                end
                %--------------------
                %(6)
                %check inner (higher sheets)
                if (k+1 < maxSheets && guessBoardAI(i,j,k+1) == 2)
                    
                    %Block the original location to avoid double-counting
                    %guessBoardAI(i,j,k) = 5;
                    
                    innerCounter = 1;
                    %Keep checking up until it runs out of board or is
                    %not a hit anymore
                    while(k+innerCounter <= maxSheets && guessBoardAI(i,j,k+innerCounter) == 2)
                        innerCounter = innerCounter + 1;
                    end
                    %Declare a shots fired counter to make sure that we
                    %only fire up to the min length ship
                    shotsFiredCounter = 0;
                    %Once it hits an empty spot (0), then start shooting
                    %Keep shooting while it is in the board, it is an
                    %empty spot, and there are still shots left, and we
                    %only shoot up to the min ship length to not waste
                    %shots (in case boards are huge)
                    while (k+innerCounter<= maxSheets && guessBoardAI(i,j,k+innerCounter) == 0 && nShotsLeft > 0 && shotsFiredCounter <= ceil((minShipLength-1)/2))
                        %Block the location to avoid double-shooting
                        guessBoardAI(i,j,k+innerCounter) = 5;
                        
                        %Store the shot in the shots store
                        type2ShotsStore(size(type2ShotsStore,1)+1,:) = [i,j,k+innerCounter];
                        %Decrement the number of shots left
                        nShotsLeft = nShotsLeft - 1;
                        %Increment the counter
                        innerCounter = innerCounter + 1;
                        %Increment the shotsFiredCounter
                        shotsFiredCounter = shotsFiredCounter + 1;
                    end
                end %end of (6)
                %--------------------
                %(7)
                %If no sides are shot, fire all possible sides
                
                %Check every side: Set to true (clear for counting as
                %not hit on that side) and set to false if there is a
                %space and it is not 2 (it has been hit and hence
                %disqualified)
                
                %Check top
                top = true;
                if (i-1 >= 1 && guessBoardAI(i-1,j,k) == 2)
                    top = false;
                end
                %Check bottom
                bottom = true;
                if (i+1 <= maxRows && guessBoardAI(i+1,j,k) == 2)
                    bottom = false;
                end
                %Check left
                left = true;
                if (j-1 >= 1 && guessBoardAI(i,j-1,k) == 2)
                    left = false;
                end
                %Check right
                right = true;
                if (j+1 <= maxCols && guessBoardAI(i,j+1,k) == 2)
                    right = false;
                end
                %Check outer
                outer = true;
                if (k-1 >= 1 && guessBoardAI(i,j,k-1) == 2)
                    outer = false;
                end
                %Check inner
                inner = true;
                if (k+1 <= maxSheets && guessBoardAI(i,j,k+1) == 2)
                    inner = false;
                end
                
                %If it clears everything, then we fire at the spots
                %that are within the board and are 0
                if (top && bottom && left && right && outer && inner)
                    %----
                    %(top)
                    %If the top is within the board, box is 0, and
                    %there are shots left, then fire the top
                    if( i-1 >= 1 && guessBoardAI(i-1,j,k) == 0 && nShotsLeft > 0 )
                        %Block the location to avoid double-shooting
                        guessBoardAI(i-1,j,k) = 5;
                        %Store the shot in the shots store
                        type2ShotsStore(size(type2ShotsStore,1)+1,:) = [i-1,j,k];
                        %Decrement the number of shots left
                        nShotsLeft = nShotsLeft - 1;
                    end
                    %----
                    %(bottom)
                    %If the bottom is within the board, box is 0, and
                    %there are shots left, then fire the bottom
                    if( i+1 <= maxRows && guessBoardAI(i+1,j,k) == 0 && nShotsLeft > 0 )
                        %Block the location to avoid double-shooting
                        guessBoardAI(i+1,j,k) = 5;
                        %Store the shot in the shots store
                        type2ShotsStore(size(type2ShotsStore,1)+1,:) = [i+1,j,k];
                        %Decrement the number of shots left
                        nShotsLeft = nShotsLeft - 1;
                    end
                    %----
                    %(left)
                    %If the left is within the board, box is 0, and
                    %there are shots left, then fire the left
                    if( j-1 >= 1 && guessBoardAI(i,j-1,k) == 0 && nShotsLeft > 0 )
                        %Block the location to avoid double-shooting
                        guessBoardAI(i,j-1,k) = 5;
                        %Store the shot in the shots store
                        type2ShotsStore(size(type2ShotsStore,1)+1,:) = [i,j-1,k];
                        %Decrement the number of shots left
                        nShotsLeft = nShotsLeft - 1;
                    end
                    %----
                    %(right)
                    %If the right is within the board, box is 0, and
                    %there are shots left, then fire the right
                    if( j+1 <= maxCols && guessBoardAI(i,j+1,k) == 0 && nShotsLeft > 0 )
                        %Block the location to avoid double-shooting
                        guessBoardAI(i,j+1,k) = 5;
                        %Store the shot in the shots store
                        type2ShotsStore(size(type2ShotsStore,1)+1,:) = [i,j+1,k];
                        %Decrement the number of shots left
                        nShotsLeft = nShotsLeft - 1;
                    end
                    %----
                    %(inner)
                    %If the inner is within the board, box is 0, and
                    %there are shots left, then fire the inner
                    if( k-1 >= 1 && guessBoardAI(i,j,k-1) == 0 && nShotsLeft > 0 )
                        %Block the location to avoid double-shooting
                        guessBoardAI(i,j,k-1) = 5;
                        %Store the shot in the shots store
                        type2ShotsStore(size(type2ShotsStore,1)+1,:) = [i,j,k-1];
                        %Decrement the number of shots left
                        nShotsLeft = nShotsLeft - 1;
                    end
                    %----
                    %(outer)
                    %If the outer is within the board, box is 0, and
                    %there are shots left, then fire the outer
                    if( k+1 <= maxSheets && guessBoardAI(i,j,k+1) == 0 && nShotsLeft > 0 )
                        %Block the location to avoid double-shooting
                        guessBoardAI(i,j,k+1) = 5;
                        %Store the shot in the shots store
                        type2ShotsStore(size(type2ShotsStore,1)+1,:) = [i,j,k+1];
                        %Decrement the number of shots left
                        nShotsLeft = nShotsLeft - 1;
                    end
                end
                
                
                %--------------------
            end%end of if (box is hit but not yet sunk)
        end %end of rows
    end %end of cols
end %end of sheets

%Check if there any duplicates to avoid double-firing.
uniqueType2ShotsStore = unique(type2ShotsStore,'rows');

end %end of function

%--------------------
%Below this is purely Pseudocode that was used. Can be
%ignored:

%if one of the other sides are hit
%check if the smaller side is already hit
%while yes, keep checking until it is either the end of
%the board or it is a miss.

%while no, fire a type 2 shot, and keep checking

%check if the larger side is already hit
%while yes, keep checking until it is either at the end
%of the board or it is a miss

%while no, fire a type 2 shot and keep checking.

%If no other side is hit
%check the range of space on the x-axis
%If >= min ship length, fire on either side (which is
%fire-able)

%check the range of space on the y-axis
%if >= min ship length, fire on either side (which is
%fire-able)

%check the range of space on the z-axis.
%if >= min ship length, fire on either size (which is
%fire-able)

%Delete the point of reference so that the next iteration will not
%come by this again (avoid "double-counting")

%End of ignore
%--------------------