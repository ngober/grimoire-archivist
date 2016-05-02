# grimoire-archivist
A script to create LaTeX documents containing the Grimoire efforts of /r/DnDBehindTheScreen

# Dependencies
Grimoire Archivist requires Python 2.7, Pandoc, and a Latex distribution containing the following packages:

 * fancyhdr
 * hyperref
 * tools
 * ulem

All relevant packages can be installed with one command:

    apt-get install python2.7 pandoc texlive


# Running
Grimoire Archivist can be run by simply calling `make`. However, there are also other make targets:

 * `make keys`: Get the reddit short codes for grimoire pages
 * `make md`: Pull the markdown content from all of the grimoire pages
 * `make tex`: Convert all markdown files in the `build/` directory to tex
 * `make pdf`: Assemble a pdf of all tex files in the `build/` directory
