# ImageDiff


## Motivation
A simple MacOS utility app for image diff. It iterates throught the pixels and marks which are different.
The idea came to mind after watching a talk about screenshot testing by [Brandon Williams](https://github.com/mbrandonw). The purpose is to have an image
of the view state to testify of how it looked in a particular version or to quickly see if someone made some UI changes
which got lost in some merge or we just aren't aware of them.
He mentioned using some propriatary software which wasn't cheap for this one functionality, so here it is...

## Example
In this example the label's leading anchor has been altered which is represented by black pixels. All pixels that remain
the same are just slightly more transparent to better contrast the difference.

![Example usage](https://github.com/baic989/ImageDiff/blob/master/example.png)

## Usage
Simply drag and drop two images from the filesystem onto two small rectangle placeholders and press "DIFF"

## Known bugs
Known bugs include:
- Crash when dragging an image from the browser (which is not on the filesystem)
- Crash when dragging a huge image e.g. 8k

## ToDo's
ToDo's include:
- dynamic alpha change instead of fixed value
