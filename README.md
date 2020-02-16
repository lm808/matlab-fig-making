# matlab-fig-making
A set of MATLAB tools to prepare figures optimised for documents, publications and presentations.

The aim is that the exported figure will require no resizing when used in documents (especially LaTeX). In this way, you have direct control on font sizes and line thickness etc. right when you produce the figure.

Released under the MIT License (included). In addition, the author reserves the rights to later publications of the project under a different licence. All usage must incorporate appropriate citation as listed below.

Disclaimer: the codes are provided 'as-is' without warranty and is used solely at the risk of the end-user.

Copyright (c) 2018-2020 lm808. All rights reserved.

## Cite as
L. Ma, matlab-fig-making (2020), open-source repository, https://github.com/lm808/matlab-fig-making/

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
- Exports MATLAB figures 'as is', other than simple formatting options for texts. 

`fFigResize.m`
- Resizes figures to fit onto a document page.

`fFigZoom.m`
- Creates a new figure which is a zoomed-in version of an existing figure.

`fAxDownSample.m`
- Down-samples the axis to reduce the exported file size.

`rule.m`
- Draws horizontal or vertical lines across a figure.

`fClr.m`
- Defines a set of colour scheme for plotting and returns their RGB.
- See 'fig_colorschm.png' for the colours and their names for using the function.

`fFigGetPos.m`
- Gets the current location and size of the figure, and copies a command to the system clipboard, so that other figures can be easily set to exaclty the same size and location.

`fAxFormat.m`
- Formats the axes with the desired text interpreter and font sizes.

Type `help <function name>` to see further documentation.

## To-do's

* Upload examples for workflow code and output files.
* Change fFigZoom to copy and then zoom an axes rather than a figure.
