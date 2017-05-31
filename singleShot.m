function newIGB = singleShot(IGB)
% IGB = Internal Guess Board, the representations to do calculation
 
% This part should be outside the single shot function
[rows,columns,sheets] = size(IGB);
nSpots = numel(IGB);
p = randperm(nSpots); % The sequence of our "random shooting"
% This part ends

newIGB = IGB;

shootIt = 0;
for i=1:nSpots
    shotIndex = p(i);
    [R, C, S] = ind2sub(size(IGB),shotIndex);
    
    % Rule 0: Never shoot a spot which was already covered
    if (IGB(shotIndex) ~= 0)
        %Continue to next iteration to regenerate new random values
        continue;
    end
    
    % Rule 1: Avoid overlapping of cover-range
    if (any(IGB(max([R-2,1]):min([R+2,rows]), C, S)) ~= 0 || ...
            any(IGB(R,max([C-2,1]):min([C+2,columns]), S)) ~= 0 || ...
            any(IGB(R,C,max([S-2,1]):min([S+2,sheets]))) ~= 0)
        continue
    end
    
    shootIt = shotIndex;
    break
end

if shootIt == 0 % When no such spot was found with Rule 1
    for i=1:nSpots
        shotIndex = p(i);
        
        % Rule 0: Never shoot a spot which was already covered
        if (IGB(shotIndex) ~= 0)
            %Continue to next iteration to regenerate new random values
            continue;
        end
        
        shootIt = shotIndex;
        break
    end
end

if shootIt == 0 % When no such spot was found without Rule 1
    disp('You exhausted all possible spots')
    return    
end

% Represent the range which is covered by the current shot
newIGB(max([R-2,1]):min([R+2,rows]), C, S)=2;
newIGB(R,max([C-2,1]):min([C+2,columns]), S)=2;
newIGB(R,C,max([S-2,1]):min([S+2,sheets]))=2;

% Represent the shot
newIGB(shootIt) = 1;




