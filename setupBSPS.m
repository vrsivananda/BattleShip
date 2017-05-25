%function setupBSPS(rows,cols,sheets)
    
    rows = 6;
    cols = 6;
    sheets = 6;
    
    shipBoard = zeros(rows,cols,sheets);
    
    %Ship sizes: 6,5,4,4,3,3,2,spaceStation
    
    %Create cell array of ship lengths
    shiplengths = [6,5,4,4,3,3,2];
    %Go through the ship lengths and delete those that do not fit
    for i = size(shiplengths,2):-1:1
        if(shiplengths(i) > rows && shiplengths(i) > cols && shiplengths(i) > sheets)
            shiplengths(i) = [];
        end
    end
    
    %Loop through the remaining ships and ask where the user wants to place
    %them
    for i = 1:size(shiplengths,2)
        disp('i = ' + num2str(i));
        theLength = shiplengths(i);
        %Flag for a redo in case entry is inappropriate
        redo = true;
        while (redo == true)
            headPlace = input(['Q: Where would you like to place the start of your length ' num2str(theLength) ' ship?\n Ans:  ']);
            
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
                %Check to see which directions are available
                
                %Create a storage for available options
                optionsStore = [];
                
                %Check downwards
                if(headPlace(1)+theLength-1 <= rows && checkRange(headPlace,[headPlace(1)+theLength-1, headPlace(2), headPlace(3)],shipBoard))
                    optionsStore(size(optionsStore,1)+1,:) = [headPlace(1)+theLength-1, headPlace(2), headPlace(3)];
                end
                
                %Check upwards
                if (headPlace(1)-theLength-1 >= 0 && checkRange(headPlace, [headPlace(1)-theLength-1, headPlace(2), headPlace(3)], shipBoard))
                    optionsStore(size(optionsStore,1)+1,:) = [headPlace(1)-theLength-1, headPlace(2), headPlace(3)];
                end
                
                %Check rightwards
                if(headPlace(2)+theLength-1 <= cols && checkRange(headPlace, [headPlace(1), headPlace(2)+theLength-1, headPlace(3)], shipBoard))
                    optionsStore(size(optionsStore,1)+1,:) = [headPlace(1), headPlace(2)+theLength-1, headPlace(3)];
                end
                
                %Check leftwards
                if (headPlace(2)-theLength-1 >= 0 && checkRange(headPlace, [headPlace(1), headPlace(2)-theLength-1, headPlace(3)], shipBoard))
                    optionsStore(size(optionsStore,1)+1,:) = [headPlace(1), headPlace(2)-theLength-1, headPlace(3)];
                end
                
                %Check inwards
                if(headPlace(3)+theLength-1 <= sheets && checkRange(headPlace, [headPlace(1), headPlace(2), headPlace(3)+theLength-1], shipBoard))
                    optionsStore(size(optionsStore,1)+1,:) = [headPlace(1), headPlace(2), headPlace(3)+theLength-1];
                end
                
                %Check outwards
                if (headPlace(3)-theLength-1 >= 0 && checkRange(headPlace, [headPlace(1), headPlace(2), headPlace(3)-theLength-1], shipBoard))
                    optionsStore(size(optionsStore,1)+1,:) = [headPlace(1), headPlace(2), headPlace(3)-theLength-1];
                end
                
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
                
                redo = false;
            end %End of if statement, that goes through all tests of validity
        end %End of while loop, to ensure validity of response
    end %End of for loop, for each ship

%end
