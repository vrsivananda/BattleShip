function ShotBoard = singleShot(oldShotBoard)
% ShotBoard = Internal Shot Mark Board
% 0 = no shots yet
% 1 = shot


% "This part" should be outside the singleShot function in the AI function
[rows,columns,sheets] = size(oldShotBoard);
nSpots = numel(oldShotBoard);
p = randperm(nSpots); % The sequence of our "random shooting"
% for the same-length ship version
theRestShipLengths = [5 5 5 5 5];
% the minimum Length of Targets
LT = min(theRestShipLengths);
% Half length of the smallest ship
hLT = floor(LT/2);
% "This part" ends
 
 
 

ShotBoard = oldShotBoard;

shootIt = 0; % The index of the spot to be shot
maxSP = 0; % Used for Rule 2, specified later

for i=1:nSpots
    shotIndex = p(i);
    
    % Rule 0: Never shoot a spot which was already shot
    if (ShotBoard(shotIndex) == 1)
        continue; % to next iteration with the next random position
    end
    
    [R, C, S] = ind2sub(size(ShotBoard),shotIndex);
    
    % The potential of containing a ship towards each sides is 0 if
    % there is no more space or 
    % some point on that side got shot but there is no hit
    Side1 = (any(ShotBoard(min([R,rows-(LT-1)]):min([R+hLT,rows]), C, ...
        S)) == 1 || R == rows); % To the bottom
    Side2 = (any(ShotBoard(max([R-hLT,1]):max([R,LT]), C, S)) == 1 || ...
        R == 1); % To the top
    Side3 = (any(ShotBoard(R,min([C,columns-(LT-1)]):min([C+hLT,columns]), ...
        S)) == 1 || C == columns); % To the right
    Side4 = (any(ShotBoard(R,max([C-hLT,1]):max([C,LT]), S)) == 1 || ...
        C == 1); % To the left
    Side5 = (any(ShotBoard(R,C,min([S,sheets-(LT-1)]):min([S+hLT,sheets]))...
        ) == 1 || S == sheets); % To higher
    Side6 = (any(ShotBoard(R,C,max([S-hLT,1]):max([S,LT]))) == 1 || ...
        S == 1); % To lower
    
    ShipPotential = 6 - (Side1 + Side2 + Side3 + Side4 + Side5 + Side6);
    
    % Rule 1: Never shoot a spot which has no possible ship on any side
    if (ShipPotential == 0)
        continue;
    end
    
    % Rule 2: Maximize the possibility to find a ship by shooting at a
    % spot which has the most potential sides
    if ShipPotential < maxSP
        continue
    end
    maxSP = ShipPotential;
    
    shootIt = shotIndex;
    break;
end

if shootIt == 0 % Type 1 Random Shot is no longer needed.
     
    % The next two lines should be replaced by terminating this function
    % and using the current fire for Type 2 Shots, etc.
    warndlg('You exhausted all possible spots for Type 1 Random Shot!')
    shootIt = shotIndex; % Shoot a random spot which is actually useless
end

% Represent the shot
ShotBoard(shootIt) = 1;




