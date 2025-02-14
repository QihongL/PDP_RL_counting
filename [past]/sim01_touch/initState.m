% INITSTATE initialize the state parameters, or set up the "world"
% written by Professor Jay McClelland
function [w] = initState(range)
% preallocation 
w.curs = 0;     % current state
w.cura = 0;     % current action 
w.nexts = 0;    % next state
w.nexta = 0;    % next action 

w.R = 0;        % reward
w.steps = 0;    % steps used
w.spotsTouched = [];    % spot touched

% generate a target randomly in the range
w.targets = randi(range);   

end

