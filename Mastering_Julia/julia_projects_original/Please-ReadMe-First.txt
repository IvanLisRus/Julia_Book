Please NOTE:
------------

I have mentioned many times in the text that Julia is still under development and has not yet reached the v1.0 stage.

One of the purposes of writing the book was to encourage you feel at home exploring the Julia environment and interacting with the Julia community.

While the code contained here worked with v0.3.x, on various platforms, at the time the book was being written but there may be problems when using v0.4 or even the latest stable v0.3

These could be:

1. Depreciated functions or syntax.

In version v0.4 the syntax for Any[] arrays, tuples, the convert() function etc., has been revised and may raise warnings when running some code.


2.  Package inclusion to Base

The DateTime functions have been incorporated into Base for v0.4 
Distributed arrays has been taken OUT of Base into separate package DistributedArrays.jl which needs to be include for v0.4 and above.


3. Changes to packages.

Package developers may need to take note of changes to Base functionality and modify their code accordingly. In some cases this can result in a change in behaviour of the package.

Also packages may be superceded, the code redistributed or the package restructed, viz by creating submodules, retiring or renaming functions, modifying the type structure.


SO:

If there are problems with the code: look at the Issues for a base or a specific package, or try googling for the problem or raise a question/issue with the developer. 

It is likely that you are not the first to encounter it.

