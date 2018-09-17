function [h] = rule(loc,type,varargin)

if nargin == 2
        options = {'b-'};
else
        options = varargin;
end

for i = 1:length(loc)
    switch type
        case 'v'
            x = [loc(i) loc(i)];
            y = get(gca,'YLim');
        case 'h'
            x = get(gca,'XLim');
            y = [loc(i) loc(i)];
        case 'ix'
            x = get(gca,'XLim');
            y = loc(i) * x;
        case 'iy'
            y = get(gca,'YLim');
            x = 1/loc(i) * y;
        otherwise
            error('Invalid type - please specify ''h'' or ''v''');
    end
    h = plot(x,y,options{:});
    
    switch type
        case 'v'
            ylim(y)
        case 'h'
            xlim(x)
    end
end

