function rule(loc,type,varargin)

% [] = rule(loc, type, ...)
% -------------------------------------------------------------------------
% Draws horizontal or vertical lines across a figure.
% Inputs: 1) loc - location of the line, can be a vector for multiple
%                  lines.
%         2) type - 'v' or 'h' to specify vertical or horizontal lines. Can
%            be a charactor vector that correpsonds to each element in the 
%            'loc' vector. If 'loc' is a vector but 'type' is not, then all
%            lines will plotted in the same way.
%         3) for lines of any gradient, set type to 'l', and loc as a 2xn
%            array, with 1st row as gradient and 2nd row as y-intercept
%         4) '...' - extra value-option pairs:
%            Any options that work with 'plot' will work here. e.g.:
%            rule(0, 'h', 'r', 'linewdith', 1.5)
% -------------------------------------------------------------------------
% lm808, 03/09

if nargin == 2
        options = {'b-'};
else
        options = varargin;
end

if numel(type) > 1 && (numel(type) ~= size(loc,2))
    error('Please specify ''h'', ''v'' or ''l'' for each line.')
end
if size(loc,2) > 1 && numel(type) == 1
    type = char(type*ones(size(loc)));
end

for i = 1:size(loc,2)
    switch type(i)
        case 'v'
            x = [loc(1,i) loc(1,i)];
            y = get(gca,'YLim');
        case 'h'
            x = get(gca,'XLim');
            y = [loc(1,i) loc(1,i)];
        case 'l'
            xl = get(gca,'XLim');
            yl = get(gca,'YLim');
            x = xl;
            y = loc(1,i) * x + loc(2,i);
        otherwise
            error('Invalid type - please specify ''h'', ''v'' or ''l''');
    end
    h = plot(x,y,options{:});
    
    switch type(i)
        case 'v'
            ylim(y)
        case 'h'
            xlim(x)
        case 'l'
            xlim(xl)
            ylim(yl);
    end
end

%         case 'ix'
%             x = get(gca,'XLim');
%             y = loc(i) * x;
%         case 'iy'
%             y = get(gca,'YLim');
%             x = 1/loc(i) * y;

