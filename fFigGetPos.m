function p = fFigGetPos(handle)

% [p] = fFigGetPos(handle)
% -------------------------------------------------------------------------
% Gets the current location and size of the figure, and copies a command to
% the system clipboard, so that other figures can be easily set to exaclty 
% the same size and location.
% - Useful when you hand-adjusted the size of a figure and want to set 
%   further figures to the % same size.
% - Usage: invoke the function with a figure handle, and press Cltr+V in
%          your code where you want to resize a different figure.
% -------------------------------------------------------------------------
% lm808, 03/2019

if nargin == 0
    handle = gcf;
end

p = get(figure(handle),'outerposition');

clipboard('copy',['set(gcf,''OuterPosition'',[',fNum2str(p,','),'])'])
