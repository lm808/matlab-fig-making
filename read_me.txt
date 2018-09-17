MATLAB Figure Preparation Toolbox for Thesis/Publication
---------------------------------------------------------
Dependency:
Linux:
	pdfcrop, usually installed as part of your TeX distribution.
	imagemagick (aka convert)
	
---------------------------------------------------------

List of functions:

fFigCapture.m
	Primary function for figure output. Output file type is recongnised by extension (last 3 charactors). Use ".try" as an extension for a trial run to see the fully-formated figure but not outputting to file.

fAxFormat.m
	The axes formatter for fFigCapture(). It is a separate function because in rare cases of complicated figures (especially when multiple axes are overlapped on top of each other to create a certain effect), axes need to be formatted in a particular order. This lower-level function exists to allow that flexibility. In this case, use ('skip_format_adj', true) when you call fFigCapture().

fFigResize.m
	Helps to resize figures for a LaTeX document. Has a lot of pre-set sizes for thesis, report and presentations. Type "help fFigResize" for details.

fFigZoom.m
	Creates a zoomed-in version of a given figure.

fClr.m
	Provides a colour scheme. See fig_colorschm.png. This colour scheme is consistent to the colour definitions provided in the section's thesis template.

fAxDownSample.m
	Reduces the number of data points on a figure in crowded areas. In the cases where the original figure has a lot of data points, this is to prevent MATLAB crashing or outputting ridiculous file sizes. 

rule.m
	Draws a horizontal or vertical line across your figure.

fFigGetPos.m
	Grabs the current location and size of a figure and copies a cammand to the clipboard so that you can re-set new figures to precisely the same location and size.

---------------------------------------------------------

Usage:

If you cannot find the instructions for a specific function, it is because I have not written it yet. In this case see the function itself, there may be some instructions.

fClr.m
   plot(x,y,'color',fClr(1))
   plot(x,y,'markeredgecolor',fClr(1),'markerfacecolor',fClr(1))
   etc.
   Colours can be referred to either by number, full name, or short-hands. For valid colour references, see fig_colorschm.png. 

rule.m
	Add ';' at the end to avoid console output.
	rule(0.1,'h','color',fClr(1),[... any other usual figure commands ...]);
	rule([0.1, 0,2],'v')
