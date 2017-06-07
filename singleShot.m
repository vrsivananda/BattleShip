function [ShotBoard, shotLocation] = singleShot(oldShotBoard,minShipLength)
% ShotBoard = Internal Shot Mark Board
% 0 = no shots yet
% 1 = shot
 
[rows,columns,sheets] = size(oldShotBoard);
nSpots = numel(oldShotBoard);
p = randperm(nSpots); % The sequence of our "random shooting"
% the minimum Length of Targets
LT = minShipLength;
% Half length of the smallest ship
hLT = floor(LT/2);
minShip = zeros(1,LT);


% 4 = Type1 shots done
% 5 = Type2 shots done


ShotBoard = oldShotBoard;

% The index of the spot to be shot
shootIt = 0;
%Get the max dimensions to avoid going off board
[rows,columns,sheets] = size(ShotBoard);

nSpots = numel(ShotBoard);
p = randperm(nSpots); % The sequence of selecting our "random shooting"

LT = minShipLength;
% Used for Rule 2, specified later
maxSP = 0;
minShip = zeros(1,LT);
% Half length of the smallest ship
hLT = floor(LT/2);

for i=1:nSpots
    shotIndex = p(i);
    
    % Rule 0: Never shoot a spot which was already shot
    if (ShotBoard(shotIndex) ~= 0)
        continue; % to next iteration with the next random position
    end
    
    [R, C, S] = ind2sub(size(ShotBoard),shotIndex);
    
    
    % The potential of containing a ship towards each sides is 0 if
    % there is no more spaces than the opposite side or
    % some point on this side got shot (assuming that we didn't get any hit
    % in this round since we can't know)
    
    s1 = 0; % The possible ships that the spot towards the bottom contains
    if R+hLT <= rows
        Side1 = ShotBoard(max([R-hLT,1]):min([R+(LT-1),rows]), C, S);
        s1 = length(strfind(Side1(:)',minShip));
    end
    s2 = 0; % Towards the top
    if R-hLT >= 1
        Side2 = ShotBoard(max([R-(LT-1),1]):min([R+hLT,rows]), C, S);
        s2 = length(strfind(Side2(:)',minShip));
    end
    s3 = 0; % Towards the right
    if C+hLT <= columns
        Side3 = ShotBoard(R, max([C-hLT,1]):min([C+(LT-1),columns]), S);
        s3 = length(strfind(Side3(:)',minShip));
    end
    s4 = 0; % Towards the left
    if C-hLT >= 1
        Side4 = ShotBoard(R, max([C-(LT+1),1]):min([C+hLT,columns]), S);
        s4 = length(strfind(Side4(:)',minShip));
    end
    s5 = 0; % Towards higher sheets
    if S+hLT <= sheets
        Side5 = ShotBoard(R, C, max([S-hLT,1]):min([S+(LT-1),sheets]));
        s5 = length(strfind(Side5(:)',minShip));
    end
    s6 = 0; % Towards lower sheets
    if S-hLT >= 1
        Side6 = ShotBoard(R, C, max([S-(LT-1),1]):min([S+hLT,sheets]));
        s6 = length(strfind(Side6(:)',minShip));
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

if shootIt == 0
    % Rule 1 is abandoned in this case because we have to abandon the
    % assumption that we didn't get any hit in this round
    for i=1:nSpots
        shotIndex = p(i);
        
        % Rule 0 still have to be applied
        if (ShotBoard(shotIndex) ~= 0)
            continue; % to next iteration with the next random position
        end
         
        shootIt = shotIndex; % Shoot a random spot with no strategies
        break
    end
end

% Represent the shot
ShotBoard(shootIt) = 4;
[Rs, Cs, Ss] = ind2sub(size(ShotBoard),shootIt);
shotLocation = [Rs, Cs, Ss];
 
end % End of function