function [fh2] = fFigZoom(fh,zoomarea,note)

fh2=figure;
copyobj(get(fh,'children'),fh2);

figure(fh)
hold on
rectangle('Position',zoomarea,'Curvature',0.2,'linestyle','--');
text(zoomarea(1)+zoomarea(3)*1.1,zoomarea(2)+zoomarea(4)/2,note)
hold off

figure(fh2)
xlim([zoomarea(1),zoomarea(1)+zoomarea(3)])
ylim([zoomarea(2),zoomarea(2)+zoomarea(4)])
xlabel('')
ylabel('')