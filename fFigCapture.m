function []=fFigCapture(handle, destinationFile, varargin)

% [] = fFigCapture(handle, destinationFile, ...)
% -------------------------------------------------------------------------
% Exports MATLAB figures 'as is', with formatting options for texts.
% - Choose file format by ending the file name with the desired extension:
%   'pdf' - PDF vector image, recommended for pdflatex
%   'png' - PNG bitmap image
%   'fig' - editable MATLAB figure file
%   'try' - run through all formatting options without exporting a file
% - '...': extra option-value pairs ('option', default) :
%   ('dpi', 300) - dots per inch of the output image
%   ('tex_interpreter', 'Latex') - text interpreter for the figure
%   ('tick_fontsz', 10) - font size of numbers on the axis
%   ('label_fontsz', 11) - font size of the axis labels (i.e. xlabel, etc)
%   ('title_fontsz', 11) - font size of the figure title
%   ('skip_format_adj', false) - skip interpreter or font changes
%   ('sep_legend', false) - export legend in a different file
% -------------------------------------------------------------------------
% lm808, 03/2019

drawnow % flush any MATLAB figures that have not been displayed yet.

%% defualts
dpi = 300;
text_interpreter = 'Latex';
tick_fontSz = 10;
label_fontSz = 11;
title_fontSz = 11;
skip_format_adj = false;
sep_legend = false;

%% parse input
n = length(varargin);
for i = 1:2:n-1
    switch lower(varargin{i})
        case 'dpi'
            dpi = varargin{i+1};
        case 'tex_interpreter'
            text_interpreter = varargin{i+1};
        case 'tick_fontsz'
            tick_fontSz = varargin{i+1};
        case 'label_fontsz'
            label_fontSz = varargin{i+1};
        case 'title_fontsz'
            title_fontSz = varargin{i+1};
        case 'skip_format_adj'
            skip_format_adj = varargin{i+1};
        case  'sep_legend'
            sep_legend = varargin{i+1};
        otherwise
            error('fFigCapture: Unknown option.')
    end
end
[~,fileName,fileExt] = fileparts(destinationFile);
type = fileExt(2:end);

%% set interpreter & font sizes
if ~skip_format_adj
    h = findobj(handle,'type','Axes');
    for i = 1:length(h)
        fAxFormat(h(i), 'tick_fontSz', tick_fontSz, ...
                        'label_fontSz', label_fontSz, ...
                        'title_fontSz', title_fontSz, ...
                        'text_interpreter', text_interpreter);
    end
    h = findobj(handle,'type','Legend');
    for i = 1:length(h)
        h(i).Interpreter = text_interpreter;
    end
    h = findobj(handle,'type','ColorBar');
    for i = 1:length(h)
        h(i).TickLabelInterpreter = text_interpreter;
    end
    h = findobj(handle,'type','Text');
    for i = 1:length(h)
        h(i).Interpreter = text_interpreter;
    end
end

%% deal with legend if required
if sep_legend
    % find the handle to legend
    h_lg = findobj(handle, 'type', 'Legend');
    % find the handle to axes associated with legend (undocumated MATLAB)
    h_ax = h_lg.Axes;
    % create new figure and copy over the axis & legend
    h_fig2 = figure;
    copyobj([h_lg, h_ax], h_fig2)
    % renew handles to point towards the copied version
    h_lg2 = findobj(h_fig2, 'type', 'Legend');
    h_ax2 = h_lg2.Axes;
    % freeze the legend
    h_lg2.AutoUpdate = 'off';
    % kill all plots & turn off the axes
    for i = 1:length(h_ax2.Children)
        h_ax2.Children(i).XData = NaN;
    end
    % while ~isempty(h_ax2.Children)
        % h_ax2.Children(1).delete
    % end
    h_ax2.Visible = 'off';
    % export legend as separate file
    fFigCapture(h_fig2,  strrep(destinationFile, fileExt, ['_legend', fileExt]))
    close(h_fig2)
    % turn off legend on the original figure
    axes(h_ax)
    legend off
end
    
switch lower(type)
    case 'fig'
        hgsave(handle,destinationFile)
    case 'pdf'
        save2pdf(handle, destinationFile, dpi)
        [status,~] = system(['pdfcrop ', destinationFile, ' ', destinationFile]);
        if status ~= 0
            warning(['fFigCapture: unable to remove PDF white margins. ',...
                     'Check if ''pdfcrop'' is installed and in PATH. ',...
                     'See ''Dependencies'' in ''README.md.'''])
        end
    case 'png'
        save2png(handle, destinationFile, dpi)
        [status,~] = system(['convert ', destinationFile, ' -trim ', destinationFile]);
        if status ~= 0
            % warning(['fFigCapture: unable to remove PNG white margins. ',...
%                      'Check if ''imagemagick/convert'' is installed and in PATH. ',...
%                      'See ''Dependencies'' in ''README.md.'''])
            cropPNG(destinationFile);
        end
    case 'try'
        % trial run only, no output will be created.
    otherwise
        disp('Unsupported file format, saving as MATLAB fig file.')
        fFigCapture(handle,[destinationFile,'.fig'])
end

%% PNG export
function save2png(handle, destinationFile, dpi)

% Backup previous settings
prePaperPosition = get(handle,'PaperPosition');

% Export figure
set(handle, 'PaperPositionMode', 'auto');
print(handle,destinationFile,'-dpng',sprintf('-r%d',dpi))

% Restore the previous settings
set(handle,'PaperPosition',prePaperPosition);

%% PNG Crop
function cropPNG(file)

thr = uint8(2^8-1);
img = imread(file);
mask = img(:,:,1)<thr & img(:,:,2)<thr & img(:,:,3)<thr;
% first row and last row that are not white
mcol = any(mask,2);
i = find(mcol, 1, 'first');
j = find(mcol, 1, 'last' );
img = img( i:j , :, :);
% first column and last column that are not white
mrow = any(mask,1);
i = find(mrow, 1, 'first');
j = find(mrow, 1, 'last' );
img = img( :, i:j, :);
imwrite(img, file)

%% PDF export
function save2pdf(handle, pdfFileName, dpi)

% Backup previous settings
prePaperType = get(handle,'PaperType');
prePaperUnits = get(handle,'PaperUnits');
preUnits = get(handle,'Units');
prePaperPosition = get(handle,'PaperPosition');
prePaperSize = get(handle,'PaperSize');

% Make changing paper type possible
set(handle,'PaperType','<custom>');

% Set units to all be the same
set(handle,'PaperUnits','inches');
set(handle,'Units','inches');

% Set the page size and position to match the figure's dimensions
position = get(handle,'Position');
set(handle,'PaperPosition',[0,0,position(3:4)]);
set(handle,'PaperSize',position(3:4));

% Save the pdf (this is the same method used by "saveas")
print(handle,'-painters', '-dpdf',pdfFileName,sprintf('-r%d',dpi))

% Restore the previous settings
set(handle,'PaperSize',prePaperSize);
set(handle,'PaperPosition',prePaperPosition);
set(handle,'Units',preUnits);
set(handle,'PaperUnits',prePaperUnits);
set(handle,'PaperType',prePaperType);