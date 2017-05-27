%function setupBSPS(rows,cols,sheets)
    
    rows = 6;
    cols = 6;
    sheets = 6;
    
    %======================================
    %===== Initialize ships lengths =======
    %======================================
    %Ship sizes: 6,5,4,4,3,3,2,spaceStation
    %Create cell array of ship lengths
    shipLengths = [6,5,4,4,3,3,2];
    
    %Go through the ship lengths and delete those that do not fit
    for i = size(shipLengths,2):-1:1
        if(shipLengths(i) > rows && shipLengths(i) > cols && shipLengths(i) > sheets)
            shipLengths(i) = [];
        end
    end
    
    %variable for number of ships
    nShips = size(shipLengths,2);
    
    %Create a variable to store if the board is 2d
    boardIs2D = ~(rows ~= 1 && cols ~= 1 && sheets ~= 1);
    
    
    %===========================================
    %===========  Setup for Human  =============
    %===========================================
    
    %Ship board for human player
    shipBoard = zeros(rows,cols,sheets);
    
    
    %Place the 2x2x2 space station first
    %If the board is not 2D, continue
    if (~boardIs2D)
        %While the place is not legit, do it again
        validLocation = false;
        while (validLocation == false)
            topLeftForward = input('\nQ: Where would you like to place the top-left-forward corner of your 2x2x2 space station? \nAns:  ');
            
            %If the the input is not a matrix, or is any size other than
            %1x3 matrix, redo the loop
            if(~ismatrix(topLeftForward) || size(topLeftForward,1) ~= 1 || size(topLeftForward,2) ~= 3)
                disp('---> Dimensions are not right. Please try again.');
                %redo the while loop and ask again
                continue;
            %Check that all the values entered are within the scope of the
            %board, -1 from the edges to fit the 2x2x2
            elseif(topLeftForward(1) < 0 || topLeftForward(1) > rows-1 || topLeftForward(2) < 0 || topLeftForward(2) > cols-1 || topLeftForward(3) < 0 || topLeftForward(3) > sheets-1)
                %If they are not, then redo the while loop and ask again
                disp('---> Location is outside board. Please choose again.');
                continue;
            %We can now place the ship on the board
            else
                
                %Place the spaceStation in the location
                shipBoard = placeSpaceStation(topLeftForward, shipBoard);
                
                disp('Space station placed!');
                
                %Change the flag to break out of while loop
                validLocation = true;
            end
        end
    end
    
    %Loop through the remaining ships and ask where the user wants to place
    %them
%    for i = 1:nShips 
    while(false) %DEBUGGING
        %disp('i = ' + num2str(i));
        disp(i);
        theLength = shipLengths(i);
        
        disp('Current board');
        disp(shipBoard);
        %Flag for a redo in case entry is inappropriate
        redo = true;
        while (redo == true)
            headPlace = input(['\nQ: Where would you like to place the start of your length ' num2str(theLength) ' ship?\nAns:  ']);
            
            %Make sure it is a matrix, has 1 row, and 3 columns
            if(~ismatrix(headPlace) || size(headPlace,1) ~= 1 || size(headPlace,2) ~= 3)
                disp('---> Dimensions are not right. Please try again.');
                %redo the while loop and ask again
                continue;
            %Check that all the values entered are within the scope of the
            %board
            elseif(headPlace(1) < 0 || headPlace(1) > rows || headPlace(2) < 0 || headPlace(2) > cols || headPlace(3) < 0 || headPlace(3) > sheets)
                %If they are not, then redo the while loop and ask again
                disp('---> Location is outside board. Please choose again.');
                continue;
            %Check that the space is indeed available on the board
            elseif(shipBoard(headPlace(1),headPlace(2),headPlace(3)) ~= 0 )
                %If it is not, then redo the while loop and ask again
                disp('---> Location is taken. Please choose again.');
                continue;
            %Continue with the asking of the second question
            else
                
                %Create a matrix of available options
                optionsStore = createOptionsStore(headPlace,theLength,shipBoard);

                %Check to see if there are any valid options. If not, then
                %re-ask the question
                if isempty(optionsStore)
                    disp('---> No possible end points for ship. Please re-select ship start position.');
                    continue;
                end
                %While loop to check that the entry is one of the options
                %listed
                invalidEntry = true;
                while (invalidEntry == true)
                    %Display the options
                    disp(['Q: Where would you like to place the end of your length ' num2str(theLength) ' ship?']);
                    disp('Please choose from the following available spaces below:');
                    for j = 1:size(optionsStore,1)
                       disp(['[' num2str(optionsStore(j,1)) ',' num2str(optionsStore(j,2)) ',' num2str(optionsStore(j,3)) ']']);
                    end
                    tailPlace = input('Ans:  ');
                    
                    %Check the entry to see if it is valid
                    for j = 1:size(optionsStore,1)
                       if (isequal(tailPlace,optionsStore(j,:)))
                           invalidEntry = false;
                           disp(invalidEntry);
                           %If one of them matches the options, then break
                           %out of the for loop and move onto the if
                           %statement below
                           break;
                       end
                    end
                    %If none of them match the entry, then display this
                    %message and redo the while loop for end position
                    if(invalidEntry == true)
                        disp('---> Invalid entry. Please select end position again.');
                    elseif (invalidEntry == false)
                        break;
                    end
                end
                
                shipBoard = fillSpots(headPlace, tailPlace, shipBoard);
                
                disp(['Length ' num2str(theLength) ' ship placed!']);
                
                redo = false;
            end %End of if statement, that goes through all tests of validity
        end %End of while loop, to ensure validity of response
    end %End of for loop, for each ship

    
    %==============================================
    %=========== Setup for Computer  ==============
    %==============================================
    
    %Create the ship board for the computer
    shipBoardComputer = zeros(rows,cols,sheets);
    
    %Place space station if board is not 2D
    if(~boardIs2D)
        %Place space station in random corner
        randSheetSS = randi(sheets-1);
        arrayOfCornersForSpaceStation = [[1,1,randSheetSS]; [1,cols-1,randSheetSS]; [rows-1,1,randSheetSS]; [rows-1,cols-1,randSheetSS]];
        shipBoardComputer = placeSpaceStation(arrayOfCornersForSpaceStation(randi(4),:),shipBoardComputer);
        disp(shipBoardComputer);
    end
    
    %Create another array of ship lengths except for the smallest ship 
    shipLengthsComputer = shipLengths(1,1:end-1);
    %Store the smallest ship separately
    smallestShip = shipLengths(end);
    
    for i = 1:nShips
        %Number of ships left in the array (we delete them once deployed)
        nShipsLeft = length(shipLengthsComputer);
        %Index of the current ship
        currentIndex = randi(nShipsLeft);
        %Current length of the ship
        currentShipLength = shipLengthsComputer(currentIndex);
        
        %If first ship, pick another random corner
        if (i == 1)
            %if the space station is in the first half of sheets, pick a random
            %sheet of the bottom half
            if(randSheetSS < sheets/2)
                randSheet = randi(sheets/2)+sheets/2;
            %If it was in the second half, then pick a place in the first
            %half
            elseif(randSheetSS > sheets/2)
                randSheet = randi(sheets/2);
            %If it was somehow strangely placed(?), just randomize it
            else
                randSheet = randi(sheets);
            end
            
            arrayOfCornersForShip = [[1,1,randSheet]; [1,cols,randSheet]; [rows,1,randSheet]; [rows,cols,randSheet]];
            %Make sure that the location chosen is available
            validLocation = false;
            while(validLocation == false)
                headPlace =  arrayOfCornersForShip(randi(4),:);
                disp(['headplace: ' num2str(headPlace)]);
                if(shipBoardComputer(headPlace) == 0)
                    validLocation = true;
                end
            end
            %Create options from the head place
            optionsStore = createOptionsStore(headPlace,currentShipLength,shipBoardComputer);
            %Select a random tail from the options
            tailPlace = optionsStore(randi(size(optionsStore,1)),:);
            disp(['tailplace: ' num2str(tailPlace)]);
            %Fill in the board
            shipBoardComputer = fillSpots(headPlace,tailPlace,shipBoardComputer);
            
        %Else if it is not the first ship nor the last (smallest) ship,
        %place them randomly
        elseif (i > 1 && i < nShips)
            %Create an empty optionsStore
            optionsStore = [];
            %While there are no options, pick another random spot to place
            %the head
            while (isempty(optionsStore))
                randRow = randi(rows);
                randCol = randi(cols);
                randSheet = randi(sheets);
                headPlace = [randRow, randCol, randSheet];
                %Create the options store
                optionsStore = createOptionsStore(headPlace, currentShipLength, shipBoardComputer);
            end
            
            tailPlace = optionsStore(randi(size(optionsStore,1)),:);
            shipBoardComputer = fillSpots(headPlace, tailPlace, shipBoardComputer);
        end
        
        disp('shipBoardComputer:');
        disp(shipBoardComputer);
        
    end
    
    
%end
