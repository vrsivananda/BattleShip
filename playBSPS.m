function playBSPS

rows = 6;
cols = 6;
sheets = 6;

disp('Q: What is the size of the 3-D board you want to play with? (e.g.[5 5 5])');
sizeBoard = input('\nAns:  ');
if ~isnumeric(sizeBoard) || any(size(sizeBoard) ~= [1 3]);
    disp('Invalid input. The default size will be applied.');
else
    rows = sizeBoard(1);
    cols = sizeBoard(2);
    sheets = sizeBoard(3);
end

[shipBoardH, shipBoardAI] = setupBSPS(rows, cols, sheets);

% Setting up the guessBoards and shots left for each player
sizeAI = size(shipBoardAI);
guessBoardH = zeros(sizeAI);
sizeH = size(shipBoardH);
guessBoardAI = zeros(sizeH);
nShotsAI = length(shipsLeft(shipBoardAI));
nShotsH = length(shipsLeft(shipBoardHuman));

% Determine which player goes first
whichP = randi(2);
% This counter also indicates the current player. (1 means human player; 2 means AI.)

anyoneWins = 0; % Whether the game is over
while ~anyoneWins
    if whichP == 1
        displayBoard(shipBoardH,guessBoardH);
        [shipBoardAI, guessBoardH, nShotsAI] = ...
            fireSalvoHuman(shipBoardAI, guessBoardH, nShotsH);
    end
    if whichP == 2
        [shipBoardH, guessBoardAI, nShotsH] = ...
            fireSalvoAI(shipBoardH, guessBoardAI, nShotsAI);
    end
    if nShotsH == 0
        anyoneWins = 1;
        disp('Game Over! Computer wins.')
    end
    if nShotsAI == 0
        anyoneWins = 1;
        disp('Congratulations! You win!')
    end
end



end