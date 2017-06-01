function ShotBoard = singleShot(oldShotBoard)
% ShotBoard = Internal Shot Mark Board
% 0 = no shots yet
% 1 = shot


% This part should be outside the singleShot function in the AI function
[rows,columns,sheets] = size(oldShotBoard);
nSpots = numel(oldShotBoard);
p = randperm(nSpots); % The sequence of our "random shooting"
% for the same-length ship version
theRestShipLengths = [5 5 5 5 5];
% the minimum Length of Targets
LT = min(theRestShipLengths);
% Half length of the smallest ship
hLT = floor(LT/2);
minShip = zeros(1,LT);
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
    % there is no more spaces than the opposite side or 
    % some point on this side got shot
    
    s1 = 0; % The potential that the spot towards the bottom contains a ship
    if R+hLT <= rows        
    Side1 = ShotBoard(max([R-hLT,1]):min([R+(LT-1),rows]), C, S);
    s1 = ~isempty(strfind(Side1(:)',minShip));
    end
    s2 = 0; % Towards the top
    if R-hLT >= 1        
    Side2 = ShotBoard(max([R-(LT-1),1]):min([R+hLT,rows]), C, S);
    s2 = ~isempty(strfind(Side2(:)',minShip));
    end
    s3 = 0; % Towards the right
    if C+hLT <= columns        
    Side3 = ShotBoard(R, max([C-hLT,1]):min([C+(LT-1),columns]), S);
    s3 = ~isempty(strfind(Side3(:)',minShip));
    end
    s4 = 0; % Towards the left
    if C-hLT >= 1        
    Side4 = ShotBoard(R, max([C-(LT+1),1]):min([C+hLT,columns]), S);
    s4 = ~isempty(strfind(Side4(:)',minShip));
    end
    s5 = 0; % Towards higher sheets
    if S+hLT <= sheets
    Side5 = ShotBoard(R, C, max([S-hLT,1]):min([S+(LT-1),sheets])); 
    s5 = ~isempty(strfind(Side5(:)',minShip));
    end
    s6 = 0; % Towards lower sheets
    if S-hLT >= 1
    Side6 = ShotBoard(R, C, max([S-(LT-1),1]):min([S+hLT,sheets]));
    s6 = ~isempty(strfind(Side6(:)',minShip));
    end
    
    ShipPotential = s1 + s2 + s3 + s4 + s5 + s6;
    
     
    % Rule 1: Never shoot a spot which has no possible ship on any side
    if (ShipPotential == 0)
        continue;
    end
    
    % Rule 2: Maximize the possibility to find a ship by shooting at a
    % spot which has the most potential sides
    if ShipPotential <= maxSP
        continue
    else
        maxSP = ShipPotential;
        shootIt = shotIndex;
    end
end

if shootIt == 0 % Type 1 Random Shot is no longer needed.
    
    % The next two lines should be replaced by terminating this function
    % and using the current fire for Type 2 Shots, etc.
    warndlg('You exhausted all possible spots for Type 1 Random Shot!')
    shootIt = shotIndex; % Shoot a random spot which is actually useless
end

% Represent the shot
ShotBoard(shootIt) = 1;