function order = getNonzeros(indices)
%% It takes a sequence of action indices and extract non-zero elements
% therefore, the output would the order that the model followed when
% touching the items. 
% global p;
order = indices(indices ~= 0);

end