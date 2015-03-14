# dist-get

**dist-get** is the successor of the [Ultilex](http://ultilex.linux-bg.org/ "ULTILEX - The Ultimate Linux Experience") project. It allows you to create and manage set of live Linux distributions in easy way, with just few console commands.  

Ultilex is 100% hand made and each new version required trmendous amount of time. On top of that, even though Ultilex provided the users with tons of boot options, many users requested either more/different options or entirely different set of distributions to be included in the compilation set. And there was no option to update any of these distributions once they were installed.

That's why I and [Petar Chakalov](http://bg.linkedin.com/in/chakalov) started **dist-get** with the idea to create a command line tool which automatically creates bootable ISO files out of live Linux distributions and manages the lifecycle of these distributions (update and remove distributions without touching any other distribution in the compilation set).

## Available Commands

Currently the project is in *proff of concept* phase but it is still fully functional. It is designed to behave in the same way both on Linux and Windows machines. Here is the list of all currently supported *dist-get* commands:

<pre>
*** dist-get help page ***

Available options: 
 
help                            Displays the current screen.

about                           Displays information about the contributors
                                to this project.

prepare URL_META_FILE [local]   Downloads and prepares a metadata bundle for
                                certain distribution. The URL_META_FILE can
                                be HTTP/HTTPS location or a local file.
                                If it is a local file, you need to use the
                                'local' parameter at the end of the command.

list                            Displays a list of all prepared and installed
                                distributions.
                                
install DISTRO_NAME [ISO_FILE]  Installs the DISTRO_NAME distribution. This
                                requires active internet connection unless
                                you provide a previously downloaded ISO file
                                as additional parameter.

update DISTRO_NAME [ISO_FILE]   Updates the DISTRO_NAME distribution. Please
                                note that you have to retrieve the metadata
                                file fisrt by executing 'dist-get prepare'.
                                Update requires active internet connection
                                unless you provide a previously downloaded ISO
                                file as additional parameter.

remove DISTRO_NAME              Removes the DISTRO_NAME distribution.

reorganize                      Builds the boot menu. This command is executed
                                automatically after install, update and remove.

cleanup [DISTRO_NAME]           Removes all temporary metadata. You can remove
                                meta data for DISTRO_NAME by providing it as
                                additional parameter. This command is executed
                                automatically before usbinstall or makeiso.

usbinstall                      Makes the current USB device to be bootable.

makeiso                         Creates a single CD ISO image which contains
                                all installed distributions.
</pre>

## Examples

Just a basic execution:

<pre>
dist-get

ERROR: Required parameter is missing. Use 'dist-get help' for more information on how to use the command.
</pre>

We have empty **list** of available metadata and distributions:

<pre>
dist-get list

Available meta data:

--nothing--

Installed distributions:

--nothing--
</pre>

Let's **prepare** one of the distributions that we have as "proof of concept".

<pre>
dist-get prepare ..\..\..\__metadata\tinycore.zip local

Processing archive: ..\..\tinycore\temp\dist.zip

Extracting  add.cfg
Extracting  includes
Extracting  menu.cfg
Extracting  meta

Everything is Ok

Files: 4
Size:       1029
Compressed: 912
</pre>

Now let's **list** again: 

<pre>
dist-get list

Available meta data:

tinycore

Installed distributions:

--nothing--
</pre>

Now we can **install** *tinycore*. Note that in this example we have already downloaded the 2.x version (the project is PoC and it's old, so...):

<pre>
dist-get install tinycore ..\..\..\..\tinycore-current.iso

..\..\tinycore\temp\add.cfg
..\..\tinycore\temp\includes
..\..\tinycore\temp\menu.cfg
..\..\tinycore\temp\meta
4 File(s) copied
        1 file(s) copied.

7-Zip 9.20  Copyright (c) 1999-2010 Igor Pavlov  2010-11-1

Processing archive: ..\..\tinycore\temp\tinycore.iso

Extracting  boot
Extracting  boot\bzImage
Extracting  boot\isolinux
Extracting  boot\isolinux\boot.cat
Extracting  boot\isolinux\boot.msg
Extracting  boot\isolinux\f2
Extracting  boot\isolinux\f3
Extracting  boot\isolinux\isolinux.bin
Extracting  boot\isolinux\isolinux.cfg
Extracting  boot\tinycore.gz
Extracting  [BOOT]\Bootable_NoEmulation.img

Everything is Ok

Folders: 2
Files: 9
Size:       10144885
Compressed: 10528768
..\..\tinycore\temp\tinycore\\boot\bzImage
1 File(s) copied
..\..\tinycore\temp\tinycore\\boot\tinycore.gz
1 File(s) copied
</pre>

If we **list** again, we will see the following:

<pre>
dist-get list

Available meta data:

tinycore

Installed distributions:

tinycore
</pre>

This means that we have *Tiny Core* in our set of live Linux distributions and we can either bootable ISO file or try to make the current media bootable (useful if we have **dist-get** on USB flash drive). Let's create ISO file:

<pre>
dist-get makeiso

mkisofs 2.01 (i686-pc-cygwin)
Scanning .
Scanning ./boot
Scanning ./boot/isolinux
Scanning ./boot/syslinux
Scanning ./tinycore
Scanning ./tinycore/isolinux
Scanning ./tinycore/meta
Scanning ./ultilex
Scanning ./ultilex/bin
Scanning ./ultilex/cfg
Scanning ./ultilex/stuff
Scanning ./ultilex/stuff/extlinux
Scanning ./ultilex/stuff/isolinux
Excluded by match: ./ultilex/stuff/isolinux/isolinux.boot
Scanning ./ultilex/stuff/syslinux
Scanning ./ultilex/stuff/tools
Scanning ./ultilex/stuff/tools/WIN
Scanning ./ultilex/stuff/tools/WIN/7z
Scanning ./ultilex/stuff/tools/WIN/mkisofs
Scanning ./ultilex/stuff/tools/WIN/properties
Scanning ./ultilex/stuff/tools/WIN/wget
Writing:   Initial Padblock                        Start Block 0
Done with: Initial Padblock                        Block(s)    16
Writing:   Primary Volume Descriptor               Start Block 16
Done with: Primary Volume Descriptor               Block(s)    1
Writing:   Eltorito Volume Descriptor              Start Block 17
Size of boot image is 4 sectors -> No emulation
Done with: Eltorito Volume Descriptor              Block(s)    1
Writing:   Joliet Volume Descriptor                Start Block 18
Done with: Joliet Volume Descriptor                Block(s)    1
Writing:   End Volume Descriptor                   Start Block 19
Done with: End Volume Descriptor                   Block(s)    1
Writing:   Version block                           Start Block 20
Done with: Version block                           Block(s)    1
Writing:   Path table                              Start Block 21
Done with: Path table                              Block(s)    4
Writing:   Joliet path table                       Start Block 25
Done with: Joliet path table                       Block(s)    4
Writing:   Directory tree                          Start Block 29
Done with: Directory tree                          Block(s)    21
Writing:   Joliet directory tree                   Start Block 50
Done with: Joliet directory tree                   Block(s)    20
Writing:   Directory tree cleanup                  Start Block 70
Done with: Directory tree cleanup                  Block(s)    0
Writing:   Extension record                        Start Block 70
Done with: Extension record                        Block(s)    1
Writing:   The File(s)                             Start Block 71
 58.33% done, estimate finish Sat Mar 14 14:07:12 2015
Total translation table size: 2048
Total rockridge attributes bytes: 10148
Total directory bytes: 41554
Path table size(bytes): 280
Done with: The File(s)                             Block(s)    8354
Writing:   Ending Padblock                         Start Block 8425
Done with: Ending Padblock                         Block(s)    150
Max brk space used 19000
8575 extents written (16 MB)

New ISO should be created now.
</pre>

The final ISO image is **ultilex.iso** and it is generted in the main repository folder.
