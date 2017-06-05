%IMPORTANT:
%This function can only be used with the rule where the ships cannot touch
%each other

%Used to calculate the number of ships left on the board (assuming that
%those that should be sunk are sunk).

function shipsLeftVector = shipsLeft(shipBoard)
    
    %Get the board dimensions
    [rows, cols, sheets] = size(shipBoard);
    
    %Declare a vector to hold the ship lengths
    shipsLeftVector = [];
    
    %Loop through all of them to find the ships
    for k = 1:sheets
        for j = 1: cols
            for i = 1:rows
                %If there is a ship, start the procedure to count the
                %length and mark the board once it is counted
                if(shipBoard(i,j,k) == 1 || shipBoard(i,j,k) == 2)
                    %Counter to keep track of ship length
                    counter = 1;
                    
                    %Replace the box with 0 to prevent double counting
                    shipBoard(i,j,k) = 0;
                    
                    %Check each side of the box to see which direction it
                    %goes
                    
                    %--------------------------
                    %If not down edge, check down
                    if(i < rows && (shipBoard(i+1,j,k) == 1 || shipBoard(i+1,j,k) == 2))
                        %Erase the spot to prevent future loops from
                        %counting
                        shipBoard(i+1,j,k) = 0;
                        
                        %Increment the counter
                        counter = counter + 1;
                        
                        %Keep checking until it is not 1 or 2
                        while (i+counter <= rows && (shipBoard(i+counter,j,k) == 1 || shipBoard(i+counter,j,k) == 2))
                           shipBoard(i+counter,j,k) = 0;
                           counter = counter + 1;
                        end
                        %Push in the counter to the shipLengthsVector
                        shipsLeftVector(length(shipsLeftVector)+1) = counter;
                        %disp(shipBoard); %debugging
                    end   
                    
                    %--------------------------
                    %If not right edge, check right
                    if(j < cols && (shipBoard(i,j+1,k) == 1 || shipBoard(i,j+1,k) == 2))
                        %Erase the spot to prevent future loops from
                        %counting
                        shipBoard(i,j+1,k) = 0;
                        
                        %Increment the counter
                        counter = counter + 1;
                        
                        %Keep checking until it is not 1 or 2
                        while (j+counter <= cols && (shipBoard(i,j+counter,k) == 1 || shipBoard(i,j+counter,k) == 2))
                           shipBoard(i,j+counter,k) = 0;
                           counter = counter + 1;
                        end
                        %Push in the counter to the shipLengthsVector
                        shipsLeftVector(length(shipsLeftVector)+1) = counter;
                        %disp(shipBoard); %debugging
                    end  
                    
                    %--------------------------
                    %If not inner(sheet) edge, check inner (sheet) 
                    if(k < sheets && (shipBoard(i,j,k+1) == 1 || shipBoard(i,j,k+1) == 2))
                        %Erase the spot to prevent future loops from
                        %counting
                        shipBoard(i,j,k+1) = 0;
                        
                        %Increment the counter
                        counter = counter + 1;
                        
                        %Keep checking until it is not 1 or 2
                        while (k+counter <= cols && (shipBoard(i,j,k+counter) == 1 || shipBoard(i,j,k+counter) == 2))
                           shipBoard(i,j,k+counter) = 0;
                           counter = counter + 1;
                        end
                        %Push in the counter to the shipLengthsVector
                        shipsLeftVector(length(shipsLeftVector)+1) = counter;
                        %disp(shipBoard); %debugging
                    end  
                end %end of if box ==1 statement
            end %end of rows
        end %end of cols
    end %end of sheets
    
    disp('shipBoard after shipsLeft:');
    disp(shipBoard);

end