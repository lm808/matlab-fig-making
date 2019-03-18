# matlab-fig-making
MATLAB toolbox to prepare figures for documents and publications.

Released under GNU General Public License version 3.

(c) lm808, 03/2019

## Usage

1. Install dependencies for your system (optional, see below).
2. Add functions to your MATLAB path.
3. Type "help <function name>" to see further documentation.

## Dependencies

GNU/Linux & macOS:

1. [pdfcrop](https://ctan.org/pkg/pdfcrop?lang=en), usually installed as part of your TeX distribution.
2. [imagemagick ](https://www.imagemagick.org/) (aka convert)

These should be available on most Linux distributions, if not already installed. They are used to trim the outputted figure so that all white margins are removed. If they are missing, fFigCapture.m will throw errors for PDF and PNG outputs, but should not affect the usage of the toolbox.

## List of functions

`fFigCapture.m`
- Exports MATLAB figures 'as is', with formatting options for texts.
	 
`fAxFormat.m`
- Formats the axes with the desired text interpreter and font sizes.

`fFigResize.m`
- Resizes figures to fit onto a document page.

`fFigZoom.m`
- Creates a new figure which is a zoomed-in version of an existing figure.

`fClr.m`
- Defines a set of colour scheme for plotting and returns their RGB.
- See 'fig_colorschm.png' for the colours and their names for using the function.

`fAxDownSample.m`
- Down-samples the axis to reduce the exported file size.

`fFigGetPos.m`
- Gets the current location and size of the figure, and copies a command to the system clipboard, so that other figures can be easily set to exaclty the same size and location.

`rule.m`
- Draws horizontal or vertical lines across a figure.

Type `help <function name>` to see further documentation.
