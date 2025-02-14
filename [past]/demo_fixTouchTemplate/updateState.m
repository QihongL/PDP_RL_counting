% written by professor Jay McClelland
function [ ] = updateState()
%this function uses the real state to update the internal state
%after Act is called to execute the hand or eye movement action

global w a d h p;

w.vS.eyePos = 0;
% assume we can target the hand position perfectly
w.vS.handPos = w.rS.handPos - w.rS.eyePos;
% the next line is the apparent new position of the target
% purturbed by scalar variability based on true targ pos
w.vS.targPos = round((w.rS.targPos - w.rS.eyePos)*(1 + randn*p.wf));
sd = p.wf*abs(w.rS.targPos - w.rS.eyePos);
if sd < p.wf
    sd = p.wf;
end
w.vS.oldInput = w.vS.visInput;
w.vS.visInput = normpdf(-50:50,w.vS.targPos,sd);
w.rS.aptargPos = w.vS.targPos + w.rS.eyePos;
w.rS.visInput = normpdf(-50:50,w.rS.aptargPos,sd);
w.stateNum = w.stateNum + 1;
% save the history
h(w.stateNum+1).w = w;
end

