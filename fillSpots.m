function output = fillSpots(headPlace, tailPlace, shipBoard)

%     %for debugging
%     disp('-----------fillSpots----------');
%     disp('headPlace:');
%     disp(headPlace);
%     disp('tailPlace:');
%     disp(tailPlace);
    
    [maxRows, maxCols, maxSheets] = size(shipBoard);
    %----------------------------------------------------------------------
    %(1)
    %If the first dimension does not match, we fill in the first dimension
    if (headPlace(1) ~= tailPlace(1))
       col = headPlace(2);
       sheet = headPlace(3);
       %If the head is larger, we fill from the tail
       if(headPlace(1) > tailPlace(1))
           row = tailPlace(1);
           finalPoint = headPlace(1);
       %If the tail is larger, we fill from the head
       elseif (headPlace(1) < tailPlace(1))
           row = headPlace(1);
           finalPoint = tailPlace(1);
       end
       %Fill in the blockers for the top and bottom of the ships
       if(row-1 >= 1)
           shipBoard(row-1, col, sheet) = 5;
       end
       if(finalPoint+1 <= maxRows)
           shipBoard(finalPoint+1, col, sheet) = 5;
       end
       
       
       %While it does not exceed the final point, keep filling the 1s and
       %blockers (5s)
       while (row ~= finalPoint+1)
           shipBoard(row, col, sheet) = 1;
           
           %Fill in the left of the row with blocker if within board
           if(col-1 >= 1)
               shipBoard(row, col-1, sheet) = 5;
           end
           %Fill in the right of the row with blocker if within board
           if(col+1 <= maxCols)
               shipBoard(row, col+1, sheet) = 5;
           end
           
           %Fill in the front of the row with blocker if within board
           if(sheet-1 >= 1)
               shipBoard(row, col, sheet-1) = 5;
           end
           %Fill in the back of the row with blocker if within board
           if(sheet+1 <= maxSheets)
               shipBoard(row, col, sheet+1) = 5;
           end
           
           %Increment the row for the while loop
           row = row + 1;
       end
    %----------------------------------------------------------------------
    %(2)
    %If the second dimension does not match, we fill in the second dimension
    elseif (headPlace(2) ~= tailPlace(2))
       row = headPlace(1);
       sheet = headPlace(3);
       %If the head is larger, we fill from the tail
       if(headPlace(2) > tailPlace(2))
           col = tailPlace(2);
           finalPoint = headPlace(2);
       %If the tail is larger, we fill from the head
       elseif (headPlace(2) < tailPlace(2))
           col = headPlace(2);
           finalPoint = tailPlace(2);
       end
       %Fill in the blockers for the left and right of the ships
       if(col-1 >= 1)
           shipBoard(row, col-1, sheet) = 5;
       end
       if(finalPoint+1 <= maxCols)
           shipBoard(row, finalPoint+1, sheet) = 5;
       end
       
       
       %While it does not exceed the final point, keep filling the 1s and
       %blockers (5s)
       while (col ~= finalPoint+1)
           shipBoard(row, col, sheet) = 1;
           
           %Fill in the top of the row with blocker if within board
           if(row-1 >=1)
               shipBoard(row-1, col, sheet) = 5;
           end
           %Fill in the bottom of the row with blocker if within board
           if(row+1 <= maxRows)
               shipBoard(row+1, col, sheet) = 5;
           end
           
           %Fill in the front of the row with blocker if within board
           if(sheet-1 >= 1)
               shipBoard(row, col, sheet-1) = 5;
           end
           %Fill in the back of the row with blocker if within board
           if(sheet+1 <= maxSheets)
               shipBoard(row, col, sheet+1) = 5;
           end
           
           
           
           %Increment the col for the while loop
           col = col + 1;
       end
    %----------------------------------------------------------------------
    %(3)
    %If the third dimension does not match, we fill in the third dimension
    elseif (headPlace(3) ~= tailPlace(3))
       row = headPlace(1);
       col = headPlace(2);
       %If the head is larger, we fill from the tail
       if(headPlace(3) > tailPlace(3))
           sheet = tailPlace(3);
           finalPoint = headPlace(3);
       %If the tail is larger, we fill from the head
       elseif (headPlace(3) < tailPlace(3))
           sheet = headPlace(3);
           finalPoint = tailPlace(3);
       end
        %Fill in the blockers for the forward and backward of the ships
       if(sheet-1 >= 1)
           shipBoard(row, col, sheet-1) = 5;
       end
       if(finalPoint+1 <= maxSheets)
           shipBoard(row, col, finalPoint+1) = 5;
       end
       
       
       %While it does not exceed the final point, keep filling the 1s and
       %blockers (5s)
       while (sheet ~= finalPoint+1)
           shipBoard(row, col, sheet) = 1;
           
           %Fill in the top of the row with blocker if within board
           if(row-1 >=1)
               shipBoard(row-1, col, sheet) = 5;
           end
           %Fill in the right of the row with blocker if within board
           if(row+1 <= maxRows)
               shipBoard(row+1, col, sheet) = 5;
           end
           
           %Fill in the left of the row with blocker if within board
           if(col-1 >= 1)
               shipBoard(row, col-1, sheet) = 5;
           end
           %Fill in the right of the row with blocker if within board
           if(col+1 <= maxCols)
               shipBoard(row, col+1, sheet) = 5;
           end
           
           %Increment the sheet for the while loop
           sheet = sheet + 1;
       end
    end
    %----------------------------------------------------------------------
    
    %If somehow more rows, cols, or sheets are added, throw an error
    if any([maxRows, maxCols, maxSheets] ~= [size(shipBoard,1),size(shipBoard,2),size(shipBoard,3)])
        error('dimensions in fillSpots do not match!');
    end
    
    %Return the updated ShipBoard
    output = shipBoard;
end