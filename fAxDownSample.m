%% Function to down sample figure
function fAxDownSample(axh,ppmm2)

% LM, 04/2016
% Bug fixes by MAB, 06/2016

% Source released under 
% GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007

% Down-samples all 'line's in the figure so that data size is smaller
% Do this after setting the figure size, as the data point density
% is calculated based on the current axes size in [cm]

% Limitations: 1) only works on 'line' type, i.e. generated using plot(x,y)
%              2) 2D plots only

% handle - figure handle
% ppmm2 - points per milimetre squared

[xscale,yscale] = fAxes2PaperUnit(axh);

set(axh,'units','centimeters');

% loop through all lines
n = length(axh.Children);
for i = 1:n
    
    % for now only treat lines
    if ~strcmpi(axh.Children(i).Type,'line')
        continue
    end
    
    % get the data out from the figure
    xdata = axh.Children(i).XData';
    ydata = axh.Children(i).YData';
    if strcmpi(axh.XScale,'log')
        xdata = log10(xdata);
    end
    if strcmpi(axh.YScale,'log')
        ydata = log10(ydata);
    end
    
    % tranform to physical coords (*10 for cm -> mm conversion)
    xdata = xdata * xscale * 10;
    ydata = ydata * yscale * 10;
    
    % snap to a grid roughly aheres to the required ppmm2
    xdata = round(xdata/(1/ppmm2))*(1/ppmm2);
    ydata = round(ydata/(1/ppmm2))*(1/ppmm2);
    
    % get one point from each grid
    [~,ikeep,~] = unique([xdata,ydata],'rows');
    ikeep = sort(ikeep,'ascend');
    
%     change data in the axis directly
    axh.Children(i).XData = axh.Children(i).XData(ikeep);
    axh.Children(i).YData = axh.Children(i).YData(ikeep);
%     if strcmpi(axh.XScale,'log')
%         xdata = 10.^(xdata);
%     end
%     if strcmpi(axh.YScale,'log')
%         ydata = 10.^(ydata);
%     end
%     axh.Children(i).XData = xdata(ikeep);
%     axh.Children(i).YData = ydata(ikeep);
end

end

function [xscale,yscale,xsh,ysh,xlm,ylm] = fAxes2PaperUnit(axh)

    set(axh,'units','centimeters');
    
    % abosolute position of axis on paper
    xsh = axh.Position(1);
    ysh = axh.Position(2);

    % get size of the axes
    lx = axh.Position(3);
    ly = axh.Position(4);

    % get the axis limits in data-space
    xlm = axh.XLim;
    ylm = axh.YLim;
    if strcmpi(axh.XScale,'log') % be aware of log scales !
        xlm = log10(xlm);
    end
    if strcmpi(axh.YScale,'log')
        ylm = log10(ylm);
    end

    % tranformation factor from axis space -> physical location on plot in [cm]
    xscale = lx/diff(xlm);
    yscale = ly/diff(ylm);
    
end
