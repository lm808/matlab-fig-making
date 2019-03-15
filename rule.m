function rule(loc,type,varargin)

% [] = rule(loc, type, [...any other usual line-format commands...])
% -------------------------------------------------------------------------
% Draws horizontal or vertical lines across a figure.
% Inputs: 1) loc - location of the line, can be a vector for multiple
%                  lines.
%         2) type - 'v' or 'h' to specify vertical or horizontal lines. Can
%            be a charactor vector that correpsonds to each element in the 
%            'loc' vector. If 'loc' is a vector but 'type' is not, then all
%            lines will plotted in the same way.
% -------------------------------------------------------------------------
% lm808, 03/09

if nargin == 2
        options = {'b-'};
else
        options = varargin;
end

if numel(type) > 1 && (numel(type) ~= numel(loc))
    error('Please specify ''v'' or ''h'' for each line.')
end
if numel(loc) > 1 && numel(type) == 1
    type = char(type*ones(size(loc)));
end

for i = 1:numel(loc)
    switch type(i)
        case 'v'
            x = [loc(i) loc(i)];
            y = get(gca,'YLim');
        case 'h'
            x = get(gca,'XLim');
            y = [loc(i) loc(i)];
        otherwise
            error('Invalid type - please specify ''h'' or ''v''');
    end
    h = plot(x,y,options{:});
    
    switch type(i)
        case 'v'
            ylim(y)
        case 'h'
            xlim(x)
    end
end

%         case 'ix'
%             x = get(gca,'XLim');
%             y = loc(i) * x;
%         case 'iy'
%             y = get(gca,'YLim');
%             x = 1/loc(i) * y;

