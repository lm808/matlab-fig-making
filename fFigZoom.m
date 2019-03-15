function [fh2] = fFigZoom(fh,zoom_area,note)

% [fh2] = fFigZoom(fh,zoomarea,note)
% -------------------------------------------------------------------------
% Creates a new figure which is a zoomed-in version of an existing figure.
% - A dashed-line rectangle will be placed on the original figure to
%   highlight the zoomed-in area, with a text note on top of the rectangle.
% Inputs: 1) fh - figure handle.
%         2) zoom_area - area to zoom in, in axes content coordinates:
%                        [x_lower_left, y_lower_left, width, height].
%         3) note - text to display on top of the rectangle.
% Output: fh2 - handle of the new, zoomed-in figure.
% -------------------------------------------------------------------------
% lm808, 03/2019

fh2=figure;
copyobj(get(fh,'children'),fh2);

figure(fh)
hold on
rectangle('Position',zoom_area,'Curvature',0.2,'linestyle','--');
text(zoom_area(1)+zoom_area(3)*1.1,zoom_area(2)+zoom_area(4)/2,note)
hold off

figure(fh2)
xlim([zoom_area(1),zoom_area(1)+zoom_area(3)])
ylim([zoom_area(2),zoom_area(2)+zoom_area(4)])
xlabel('')
ylabel('')