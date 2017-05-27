function output = createOptionsStore(headPlace, theLength, shipBoard)

    rows = size(shipBoard,1);
    cols = size(shipBoard,2);
    %sheets = size(shipBoard,3);

    optionsStore = [];
                    
    %Check downwards
    if(headPlace(1)+theLength-1 <= rows && checkRange(headPlace,[headPlace(1)+theLength-1, headPlace(2), headPlace(3)],shipBoard))
        optionsStore(size(optionsStore,1)+1,:) = [headPlace(1)+theLength-1, headPlace(2), headPlace(3)];
    end

    %Check upwards
    if (headPlace(1)-theLength+1 >= 1 && checkRange(headPlace, [headPlace(1)-theLength+1, headPlace(2), headPlace(3)], shipBoard))
        optionsStore(size(optionsStore,1)+1,:) = [headPlace(1)-theLength+1, headPlace(2), headPlace(3)];
    end

    %Check rightwards
    if(headPlace(2)+theLength-1 <= cols && checkRange(headPlace, [headPlace(1), headPlace(2)+theLength-1, headPlace(3)], shipBoard))
        optionsStore(size(optionsStore,1)+1,:) = [headPlace(1), headPlace(2)+theLength-1, headPlace(3)];
    end

    %Check leftwards
    if (headPlace(2)-theLength+1 >= 1 && checkRange(headPlace, [headPlace(1), headPlace(2)-theLength+1, headPlace(3)], shipBoard))
        optionsStore(size(optionsStore,1)+1,:) = [headPlace(1), headPlace(2)-theLength+1, headPlace(3)];
    end
    
% Commented out because we cannot go through sheets
%     %Check inwards
%     if(headPlace(3)+theLength-1 <= sheets && checkRange(headPlace, [headPlace(1), headPlace(2), headPlace(3)+theLength-1], shipBoard))
%         optionsStore(size(optionsStore,1)+1,:) = [headPlace(1), headPlace(2), headPlace(3)+theLength-1];
%     end
% 
%     %Check outwards
%     if (headPlace(3)-theLength-1 >= 0 && checkRange(headPlace, [headPlace(1), headPlace(2), headPlace(3)-theLength-1], shipBoard))
%         optionsStore(size(optionsStore,1)+1,:) = [headPlace(1), headPlace(2), headPlace(3)-theLength-1];
%     end

    output = optionsStore;

end