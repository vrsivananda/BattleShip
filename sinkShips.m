%IMPORTANT:
%This function can only be used with the rule where the ships cannot touch
%each other

%Used to sink the ships which need to be sunk

function [shipBoard, guessBoard] = sinkShips(shipBoard, guessBoard)
    
    %Get the board dimensions
    [rows, cols, sheets] = size(shipBoard);
    

    
    %Loop through all of them to find the ships
    for k = 1:sheets
        for j = 1: cols
            for i = 1:rows
                %Declare a vector to hold the ship boxes (that we will convert to
                %'sunk' if it needs to be sunk)
                shipBoxesStore = [];
                
                %Flag to sink ship
                sinkTheShip = false;
                
                %If there is a ship that is hit, keep the location in the
                %shipBoxes matrix
                if(shipBoard(i,j,k) == 2)
                    %Counter to keep track of the ship length and to 
                    %iterate over the boxes
                    counter = 1;
                    
                    %Add the first box into the store
                    shipBoxesStore(size(shipBoxesStore,1)+1,:) = [i,j,k];
                    
                    %Replace the box with 0 to prevent double counting
                    shipBoard(i,j,k) = 0;
                    
                    %Check each side of the box to see which direction it
                    %goes
                    
                    %--------------------------
                    %If not down edge, check down
                    if(i < rows && shipBoard(i+1,j,k) == 2)
                        %Flag to sink the ship since the length is larger
                        %than 2
                        sinkTheShip = true;
                        
                        %If it is, then add it to the shipBoxes store
                        shipBoxesStore(size(shipBoxesStore,1)+1,:) = [i+1,j,k];
                        
                        %Erase the spot to prevent future loops from
                        %counting
                        shipBoard(i+1,j,k) = 0;
                        
                        %Increment the counter
                        counter = counter + 1;
                        
                        %Keep checking until it is not 2
                        while (i+counter <= rows && shipBoard(i+counter,j,k) == 2)
                           shipBoard(i+counter,j,k) = 0;
                           shipBoxesStore(size(shipBoxesStore,1)+1,:) = [i+counter,j,k];
                           counter = counter + 1;
                        end
                        
                        %If the end is not the edge, and is 1, then set
                        %flag to false
                        if (i+counter <= rows && shipBoard(i+counter,j,k) == 1)
                            sinkTheShip = false;
                        else
                            %restart the counter and count the other way
                            counter = 1;
                            
                            %Keep checking the opposite direction until it is not 2
                            while (i-counter >= 1 && shipBoard(i-counter,j,k) == 2)
                               shipBoard(i-counter,j,k) = 0;
                               shipBoxesStore(size(shipBoxesStore,1)+1,:) = [i-counter,j,k];
                               counter = counter + 1;
                            end
                            
                            if (i-counter >= 1 && shipBoard(i-counter,j,k) == 1)
                                sinkTheShip = false;
                            end
                        end
                    end
                    %--------------------------
                    %If not right edge, check right
                    if(j < cols && shipBoard(i,j+1,k) == 2)
                        %Flag to sink the ship since the length is larger
                        %than 2
                        sinkTheShip = true;
                        
                        %If it is, then add it to the shipBoxes store
                        shipBoxesStore(size(shipBoxesStore,1)+1,:) = [i,j+1,k];
                        
                        %Erase the spot to prevent future loops from
                        %counting
                        shipBoard(i,j+1,k) = 0;
                        
                        %Increment the counter
                        counter = counter + 1;
                        
                        %Keep checking until it is not 2
                        while (j+counter <= cols && shipBoard(i,j+counter,k) == 2)
                           shipBoard(i,j+counter,k) = 0;
                           shipBoxesStore(size(shipBoxesStore,1)+1,:) = [i,j+counter,k];
                           counter = counter + 1;
                        end
                        
                        %If the end is not the edge, and is 1, then set
                        %flag to false
                        if (j+counter <= cols && shipBoard(i,j+counter,k) == 1)
                            sinkTheShip = false;
                        else
                            %restart the counter and count the other way
                            counter = 1;
                            
                            %Keep checking the opposite direction until it is not 2
                            while (j-counter >= 1 && shipBoard(i,j-counter,k) == 2)
                               shipBoard(i,j-counter,k) = 0;
                               shipBoxesStore(size(shipBoxesStore,1)+1,:) = [i,j-counter,k];
                               counter = counter + 1;
                            end
                            
                            if (j-counter >= 1 && shipBoard(i,j-counter,k) == 1)
                                sinkTheShip = false;
                            end
                        end
                    end
                    %--------------------------
                    %If not inner edge, check inner
                    if(k < sheets && shipBoard(i,j,k+1) == 2)
                        %Flag to sink the ship since the length is larger
                        %than 2
                        sinkTheShip = true;
                        
                        %If it is, then add it to the shipBoxes store
                        shipBoxesStore(size(shipBoxesStore,1)+1,:) = [i,j,k+1];
                        
                        %Erase the spot to prevent future loops from
                        %counting
                        shipBoard(i,j,k+1) = 0;
                        
                        %Increment the counter
                        counter = counter + 1;
                        
                        %Keep checking until it is not 2
                        while (k+counter <= sheets && shipBoard(i,j,k+counter) == 2)
                           shipBoard(i,j,k+counter) = 0;
                           shipBoxesStore(size(shipBoxesStore,1)+1,:) = [i,j,k+counter];
                           counter = counter + 1;
                        end
                        
                        %If the end is not the edge, and is 1, then set
                        %flag to false
                        if (k+counter <= sheets && shipBoard(i,j,k+counter) == 1)
                            sinkTheShip = false;
                        else
                            %restart the counter and count the other way
                            counter = 1;
                            
                            %Keep checking the opposite direction until it is not 2
                            while (k-counter >= 1 && shipBoard(i,j,k-counter) == 2)
                               shipBoard(i,j,k-counter) = 0;
                               shipBoxesStore(size(shipBoxesStore,1)+1,:) = [i,j,k-counter];
                               counter = counter + 1;
                            end
                            
                            if (k-counter >= 1 && shipBoard(i,j,k-counter) == 1)
                                sinkTheShip = false;
                            end
                        end
                    end %End of if there is a ship that is hit (== 2)  
                    
                    %Sink the ship if true
                    if (sinkTheShip)
                       for h = 1:size(shipBoxesStore,1)
                           currentCoordinates = shipBoxesStore(h,:);
                           shipBoard(currentCoordinates(1),currentCoordinates(2),currentCoordinates(3)) = 3;
                           %update the guessBoard with the sunk ship
                           guessBoard(currentCoordinates(1),currentCoordinates(2),currentCoordinates(3)) = 3;
                           
                       end
                    %If not, restore back all the 2s
                    else
                        for h = 1:size(shipBoxesStore,1)
                           currentCoordinates = shipBoxesStore(h,:);
                           shipBoard(currentCoordinates(1),currentCoordinates(2),currentCoordinates(3)) = 2;
                       end
                    end %end of if(sinkTheShip)
                    
                end %end of if box ==2 statement
            end %end of rows
        end %end of cols
    end %end of sheets
    
    disp('shipBoard after sinkShips:');
    disp(shipBoard);

end