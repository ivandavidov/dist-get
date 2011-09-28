A simple proof of concept how to read standard '.properties' file in Windows.

See 'sample.bat' for technical information.

The '.properties' file has the following standard format:

# This is a comment line
key1=value1
key2=value2
...
keyn=valuen
...

The implementation is done by using GNU binutils for Windows. The same approach
should work wit little (or no) modifications under Linux environment.
A good document to start with is this one:

http://merereflections.wordpress.com/2010/01/18/reading-properties-files-in-linux-shell-scripts/

There is no Windows implementation of the 'tail' command which requires a little hack. See
the 'readproperty.bat' implementation with the artificial 'for' loop inside. This is the
only way to read just one line when we have multiple matches.

The code works both with UNIX and Windows line ending. The sed/grep/tail approach is not yet
tested under Linux environment.
