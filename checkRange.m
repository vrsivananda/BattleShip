function output = checkRange(headPlace, tailPlace, shipBoard)    
%     %for debugging
%     disp('-----------checkRange----------');
%     disp('headPlace:');
%     disp(headPlace);
%     disp('tailPlace:');
%     disp(tailPlace);
    
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
        range = shipBoard(headPlace(1),headPlace(2),tailPlace(3):headPlace(3));
    else
        range = 1;
    end
    
    %Check if taken (if any of them are 1)
    isTaken = any(any(range,1));
    %Check if taken (if any of them are 5)
    isBlocked = any(any(range,5));
    
    %If neither taken nor blocked, then it is available
    rangeIsAvailable = (~isTaken && ~isBlocked);
    
    %return if it is available
    output = rangeIsAvailable;
end