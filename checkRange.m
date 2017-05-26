function output = checkRange(headPlace, tailPlace, shipBoard)
    
    %If head < tail, start from head
    
    if(headPlace(1) < tailPlace(1))
        range = shipBoard(headPlace(1):tailPlace(1),headPlace(2),headPlace(3));
    elseif(headPlace(1) > tailPlace(1))
        range = shipBoard(tailPlace(1):headPlace(1),headPlace(2),headPlace(3));
    elseif(headPlace(2) < tailPlace(2))
        range = shipBoard(headPlace(1),headPlace(2):tailPlace(2),headPlace(3));
    elseif(headPlace(2) > tailPlace(2))
        range = shipBoard(headPlace(1),tailPlace(2):headPlace(2),headPlace(3));
    elseif(headPlace(3) < tailPlace(3))
        range = shipBoard(headPlace(1),headPlace(2),headPlace(3):tailPlace(3));
    elseif(headPlace(3) > tailPlace(3))
        range = shipBoard(headPlace(1),headPlace(2),tailPlace(3):tailPlace(3));
    else
        range = 1;
    end
    
    isTaken = any(any(range,1));
    
    output = ~isTaken;
end