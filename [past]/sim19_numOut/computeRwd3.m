function Rwd = computeRwd3()
%% this function controls the reward policy
global w p h;
w.actionCorrect = true;
% if there is remaining items
if targetRemain()
    if w.out.handStep == 0      % not moving
        if w.out.countWord == 0
            Rwd = p.r.smallNeg;
        else
            Rwd = p.r.midNeg;
        end
    elseif ~isTouchingObj       % touching empty spot
        if w.out.countWord == 0
            Rwd = p.r.smallNeg;
        else
            Rwd = p.r.midNeg;
        end
    elseif objIsTouched         % touching touched object
        Rwd = p.r.midNeg;
        w.actionCorrect = false;
%     elseif ~isNext  % not touching left most untouched obj
%         Rwd = p.r.midNeg;
%         w.actionCorrect = false;
%         touchTarget()
    else            % CORRECT: touching left most untouched obj
%         Rwd = p.r.midPos;
%         touchTarget()
        if w.out.countWord == sum(w.rS.targRemain == 0)
            Rwd = p.r.midPos;
            touchTarget()
        else
            Rwd = p.r.smallNeg;
        end
    end
else    % if all targets were touched
    if w.out.countWord == w.nItems
        Rwd = p.r.bigPos;
        w.done = true;
    else
        Rwd = p.r.smallNeg;
    end
end

end % end of the function


%% Here're some helper functions to check some conditions

function touchTarget()
global w;
% mark the object
w.rS.targRemain(w.rS.handPos == w.rS.targPos) = false;
% increment the current correct number to say
% w.curCorrectNum = w.curCorrectNum +1;
% if w.curCorrectNum > w.nItems 
%     error('Current correct number cannot be bigger than number of items!');
% end
end

% check if the model is touching the leftmost untouched item
function isnext = isNext()
global w;
% if it is the leftmost untouched item
if sum(w.rS.targRemain(1:find(w.rS.targPos == w.rS.handPos))) == 1
    isnext = true;
else
    isnext = false;
end
end

% check if the model is touching an object
function isTouching = isTouchingObj()
global w;
if any(w.rS.handPos == w.rS.targPos)
    isTouching = true;
else
    isTouching = false;
end
end

% check if the model that the model is touching is untouched object
% assuming an object is being touched
function isTouched = objIsTouched()
global w;
if w.rS.targRemain(w.rS.handPos == w.rS.targPos) == true
    isTouched = false;
else
    isTouched = true;
end
end

% check if there exists untouched objects
function exist = targetRemain()
global w;
if any(w.rS.targRemain == true)
    exist = true;
else
    exist = false;
end
end

% find the real-state position of the left most untouched item
function position = nextObjPosition()
global w;
nextItemIdx = find(w.rS.targRemain, true, 'first');
position = w.rS.targPos(nextItemIdx);
end