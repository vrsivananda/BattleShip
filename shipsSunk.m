%IMPORTANT:
%This function can only be used with the rule where the ships cannot touch
%each other

%Used to calculate the ships sunk on the board.

function sunkShipsVector = shipsSunk(shipBoard)
    
    %Get the board dimensions
    [rows, cols, sheets] = size(shipBoard);
    
    %Declare a vector to hold the ship lengths
    sunkShipsVector = [];
    
    %Loop through all of them to find the ships
    for k = 1:sheets
        for j = 1: cols
            for i = 1:rows
                %If there is a sunk ship, start the procedure to count the
                %length and mark the board once it is counted
                if(shipBoard(i,j,k) == 3)
                    %Counter to keep track of ship length
                    counter = 1;
                    
                    %Replace the box with 0 to prevent double counting
                    shipBoard(i,j,k) = 0;
                    
                    %Check each side of the box to see which direction it
                    %goes
                    
                    %--------------------------
                    %If not down edge, check down
                    if(i < rows && shipBoard(i+1,j,k) == 3)
                        %Erase the spot to prevent future loops from
                        %counting
                        shipBoard(i+1,j,k) = 0;
                        
                        %Increment the counter
                        counter = counter + 1;
                        
                        %Keep checking until it is not 1 or 2
                        while (i+counter <= rows && (shipBoard(i+counter,j,k) == 3))
                           shipBoard(i+counter,j,k) = 0;
                           counter = counter + 1;
                        end
                        %Push in the counter to the shipLengthsVector
                        sunkShipsVector(length(sunkShipsVector)+1) = counter;
                        %disp(shipBoard); %debugging
                    end   
                    
                    %--------------------------
                    %If not right edge, check right
                    if(j < cols && (shipBoard(i,j+1,k) == 3))
                        %Erase the spot to prevent future loops from
                        %counting
                        shipBoard(i,j+1,k) = 0;
                        
                        %Increment the counter
                        counter = counter + 1;
                        
                        %Keep checking until it is not 1 or 2
                        while (j+counter <= cols && (shipBoard(i,j+counter,k) == 3))
                           shipBoard(i,j+counter,k) = 0;
                           counter = counter + 1;
                        end
                        %Push in the counter to the shipLengthsVector
                        sunkShipsVector(length(sunkShipsVector)+1) = counter;
                        %disp(shipBoard); %debugging
                    end  
                    
                    %--------------------------
                    %If not inner(sheet) edge, check inner (sheet) 
                    if(k < sheets && (shipBoard(i,j,k+1) == 3))
                        %Erase the spot to prevent future loops from
                        %counting
                        shipBoard(i,j,k+1) = 0;
                        
                        %Increment the counter
                        counter = counter + 1;
                        
                        %Keep checking until it is not 1 or 2
                        while (k+counter <= sheets && (shipBoard(i,j,k+counter) == 3))
                           shipBoard(i,j,k+counter) = 0;
                           counter = counter + 1;
                        end
                        %Push in the counter to the shipLengthsVector
                        sunkShipsVector(length(sunkShipsVector)+1) = counter;
                        %disp(shipBoard); %debugging
                    end  
                end %end of if box ==1 statement
            end %end of rows
        end %end of cols
    end %end of sheets
    
%     disp('shipBoard after shipsSunk:');
%     disp(shipBoard);

end