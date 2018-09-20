function []=fFigCapture(handle, destinationFile, varargin)

%% defualts
dpi = 300;
text_interpreter = 'Latex';
tick_fontSz = 10;
label_fontSz = 11;
title_fontSz = 11;
skip_format_adj = false;

%% parse input
n = length(varargin);
for i = 1:2:n-1
    switch varargin{i}
        case 'dpi'
            dpi = varargin{i+1};
        case 'tex_interpreter'
            text_interpreter = varargin{i+1};
        case 'tick_fontSz'
            tick_fontSz = varargin{i+1};
        case 'label_fontSz'
            label_fontSz = varargin{i+1};
        case 'title_fontSz'
            title_fontSz = varargin{i+1};
        case 'skip_format_adj'
            skip_format_adj = varargin{i+1};
        otherwise
            error('fFigCapture: Unknown option.')
    end
end
type = strsplit(destinationFile, '.');
type = type{end};

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
end

%% output figure
switch type
    case 'fig'
        hgsave(handle,destinationFile)
    case 'pdf'
%         handle.PaperPositionMode = 'auto';
%         fig_pos = handle.PaperPosition;
%         handle.PaperSize = [fig_pos(3) fig_pos(4)];
        save2pdf(destinationFile,handle,dpi)
%         print(handle,'-dpdf',destinationFile,sprintf('-r%d',dpi))
        system(['pdfcrop ',destinationFile,' ',destinationFile])
    case 'png'
%         pdfname = [destinationFile(1:end-3),'pdf'];
%         fFigCapture(handle,pdfname)
%         system(['convert -quality 100 -density 300 -antialias ',pdfname,' ',destinationFile]);
%         delete(pdfname);
        set(handle, 'PaperPositionMode', 'auto');
        print(handle,destinationFile,'-dpng',sprintf('-r%d',dpi))
        system(['convert ',destinationFile,' -trim ',destinationFile]);
    case 'try'
        % trial run only, no output will be created.
    otherwise
        disp('Unsupported file format, saving as MATLAB fig file.')
        fFigCapture(handle,[destinationFile,'.fig'])
end