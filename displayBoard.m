function displayBoard(shipBoard,guessBoard)
% Red: -1 - empty space at which a shot has been fired;
% Yellow: 0 – empty space: no ship, no shots fired;
% Green: 1 – space which contains your ship;
% Blue: 2 – space which contains an enemy ship and at which a
%       shot has been fired (in that space);
% Magenta: 3 – space which contains a ship that has been sunk.

% Check inputs
if nargin ~= 2
    error('your input arguments of displayBoard must be 2');
end
% Check board dimensions
if ndims(shipBoard) ~= 3 || ndims(guessBoard) ~= 3
    error('each board must be a matrix with 3 dimensions')
end
% Check board spaces
if any(~(shipBoard == 1 | shipBoard == 2 | shipBoard == 3 ...
        | shipBoard == 0 | shipBoard == -1 | guessBoard == 2 ...
        | guessBoard == 3 | guessBoard == -1))
    error(['the elements in shipBoard must be an integer from ' ...
        '-1 to 3, the elements in guessBoard must be -1, 2, or 3']);
end


% Plot each layer of the board with a colormap image

% Determine subplots display by the number of layers
% for the player's board
[h1,w1,l1] = size(shipBoard);
rowPlots1 = ceil(sqrt(l1));
columnPlots1 = ceil(l1/rowPlots1);
% for the guess board
[h2,w2,l2] = size(guessBoard);
rowPlots2 = ceil(sqrt(l2));
columnPlots2 = ceil(l2/rowPlots2);

% Preset figure sizes and position
leftF = 10;
bottomF = 10;
gapF = leftF;
size1 = [columnPlots1 rowPlots1].*200;
size2 = [columnPlots2 rowPlots2].*200;
 
% Plot the player's shipBoard
figure('NumberTitle', 'off', 'Name', 'My Current Ship Board',...
    'Position',[leftF bottomF size1]);
colormap hsv;
axis on;
% Draw each layer
for i1=1:l1
    thisLayer = shipBoard(:,:,i1);
    subplot(rowPlots1,columnPlots1,i1);
    image(14.*(thisLayer+1));
    title(['Layer' num2str(i1)]);
end
 
% Plot the guessBoard
figure('NumberTitle', 'off', 'Name', 'Current Guess Board',...
    'Position',[leftF+size1(1)+gapF bottomF size2]);
colormap hsv;
axis on;
% Draw each layer
for i2=1:l2
    thisLayer = guessBoard(:,:,i2);
    subplot(rowPlots2,columnPlots2,i2);
    image(14.*(thisLayer+1));
    title(['Layer' num2str(i2)]);
end




