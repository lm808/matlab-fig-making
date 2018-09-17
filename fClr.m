function [clr] = fClr(i,~)

if ischar(i)
    i = lower(i);
end

switch i
    case {1,'b','blue'}
        clr = [0 114 189];%[24 142 255];%
    case {2,'r','red'}
        clr = [255 0 0]; %[220 20 50];%
    case {3,'k','black'}
        clr = [0 0 0];
    case {4,'g','green'}
        clr = [40 169 10];
    case {5,'y','yellow'}
        clr = [255 198 0];
    case {6,'v','violet'}
        clr = [151 14 214];
    case {7,'o','orange'}
        clr = [255 137 0];
    case {8,'t','teal'}
        clr = [0 224 169];
    case {9,'m','magenta'}
        clr = [247 23 240];
    case {10,'l','lime'}
        clr = [200 206 23];
    case {11,'lb','lightblue','sky'}
        clr = [153 215 255];
    case {12,'lr','lightred','salmon'}
        clr = [255 128 128];
    case {13,'lk','lightblack','grey'}
        clr = [128 128 128];
    case {14,'lg','lightgreen','spring'}
        clr = [129 246 101];
    case {15,'ly','lightyellow','sand'}
        clr = [255 226 128];
    case {16,'lv','lightviolet','plum'}
        clr = [199 100 245];
    case {17,'lo','lightorange','sun'}
        clr = [255 164 76];
    case {18,'lt','lightteal','aqua'}
        clr = [128 255 236];
    case {19,'lm','lightmagenta','orchid'}
        clr = [251 151 248];
    case {20,'ll','lightlime','wasabi'}
        clr = [221 238 106];
    otherwise
        error('Unknown colour.')
end

clr = clr/255;

if nargin > 1
    figure
    hold on
    for i=1:10
        plot([0:2:100],i*ones(1,51),'color',fClr(i),'linewidth',5)
        plot([0:2:100],i*ones(1,51)+0.3,'x','color',fClr(i+10),'markersize',8)
    end
    ylim([0.5 10.5])
    ticks = [1 1 2 2 3 3 4 4 5 5 6 6 7 7 8 8 9 9 10 10];
    ticks(2:2:end) = ticks(2:2:end)+0.3;
    set(gca,'YTick',ticks)
    set(gca,'YTickLabel',{'1/blue/b','11/sky/lightblue/lb','2/red/r','12/salmon/lightred/lr',...
                          '3/black/b','13/grey/lightblack/lk','4/green/g','14/spring/lightgreen/lg',...
                          '5/yellow/y','15/sand/lightyellow/ly','6/violet/v','16/plum/lightviolet/lv',...
                          '7/orange/o','17/sun/lightorange/lo','8/teal/t','18/aqua/lightteal/lt',...
                          '9/magenta/m','19/orchid/lightmagenta/lm','10/lime/l','20/wasabi/lightlime/ll'})
    hold off
end
    
% clr{1} = [255 0 0]/255;
% clr{2} = [24 142 255]/255;
% clr{3} = [0 0 0]/255;
% clr{4} = [40 207 0]/255;
% clr{5} = [255 198 0]/255;
% clr{6} = [151 14 214]/255;
% clr{7} = [255 137 0]/255;
% clr{8} = [0 224 169]/255;
% clr{9} = [247 23 240]/255;
% clr{10} = [200 206 23]/255;
% clr{11} = [255 128 128]/255;
% clr{12} = [137 223 253]/255;
% clr{13} = [128 128 128]/255;
% clr{14} = [126 255 95]/255;
% clr{15} = [255 226 128]/255;
% clr{16} = [199 100 245]/255;
% clr{17} = [255 164 76]/255;
% clr{18} = [128 255 236]/255;
% clr{19} = [251 151 248]/255;
% clr{20} = [221 238 106]/255;
% 
% clr = clr{i};
