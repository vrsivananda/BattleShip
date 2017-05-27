function output = placeSpaceStation(topLeftForward, shipBoard)
    
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
    
    output = shipBoard;
end