function output = placeSpaceStation(topLeftForward, shipBoard)
    
    %Initialize boardLimits
    maxRows = size(shipBoard,1);
    maxCols = size(shipBoard,2);
    maxSheets = size(shipBoard,3);
    
    %Initialize variables for easy allocation
    row = topLeftForward(1);
    col = topLeftForward(2);
    sheet = topLeftForward(3);

    %First row
    shipBoard(row,col,sheet) = 1;
    shipBoard(row,col+1,sheet) = 1;
    shipBoard(row,col,sheet+1) = 1;
    shipBoard(row,col+1,sheet+1) = 1;

    %Second row
    shipBoard(row+1,col,sheet) = 1;
    shipBoard(row+1,col+1,sheet) = 1;
    shipBoard(row+1,col,sheet+1) = 1;
    shipBoard(row+1,col+1,sheet+1) = 1;
    
    
    %-------------Place blockers around ship----------
    % Row above Top Layer
    if(row-1 > 0)
       shipBoard(row-1,col,sheet) = 5; 
        shipBoard(row-1,col+1,sheet) = 5;
        shipBoard(row-1,col,sheet+1) = 5;
        shipBoard(row-1,col+1,sheet+1) = 5;
    end
    % Row below Bottom Layer
    if(row+1 <= maxRows)
        shipBoard(row+2,col,sheet) = 5; 
        shipBoard(row+2,col+1,sheet) = 5;
        shipBoard(row+2,col,sheet+1) = 5;
        shipBoard(row+2,col+1,sheet+1) = 5;
    end
    
    % Left of above left Layer
    if(col-1 > 0)
        shipBoard(row,col-1,sheet) = 5; 
        shipBoard(row+1,col-1,sheet) = 5;
        shipBoard(row,col-1,sheet+1) = 5;
        shipBoard(row+1,col-1,sheet+1) = 5;
    end
    % Right of right Layer
    if(col+2 <= maxCols)
        shipBoard(row,col+2,sheet) = 5; 
        shipBoard(row+1,col+2,sheet) = 5;
        shipBoard(row,col+2,sheet+1) = 5;
        shipBoard(row+1,col+2,sheet+1) = 5;
    end
    
    % Near(outer) of above new(outer) Layer
    if(sheet-1 > 0)
        shipBoard(row,col,sheet-1) = 5; 
        shipBoard(row+1,col,sheet-1) = 5;
        shipBoard(row,col+1,sheet-1) = 5;
        shipBoard(row+1,col+1,sheet-1) = 5;
    end
    % Far(inner) of far(inner) Layer
    if(sheet+2 <= maxSheets)
        shipBoard(row,col,sheet+2) = 5; 
        shipBoard(row+1,col,sheet+2) = 5;
        shipBoard(row,col+1,sheet+2) = 5;
        shipBoard(row+1,col+1,sheet+2) = 5;
    end
    
    output = shipBoard;
end