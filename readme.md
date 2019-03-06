# Batch: GetSizeExt batch script by Aeneas Of Troy
![alt text](https://github.com/aeneasoftroy/bat-getsizeext/blob/master/_GetSizeExt.png)

Commented batch script that adds up the total size of files with a certain extension.

This is a little helper script for compression benchmarking which also doubles as scriptable detailed file size reporting tool.
the script recursively searches for the given file extension(s) and reports the cumulative size.

# Usage examples:
_GetSizeExt.bat * "%CD%\Dataset"

_GetSizeExt.bat "wav,jpg" "%CD%\audiofiles"

_GetSizeExt.bat "zip,rar,nz,rz,ace,wav,mp3,jpg" "%CD%\files"


# calling the script from another batch:
call "%SCRIPTHOMEDIR%\_GetSizeExt.bat" * "%CD%"

call "%SCRIPTHOMEDIR%\_GetSizeExt.bat" "zip,rar,nz,rz,ace,wav,mp3,jpg" "%CD%" >> "%SCRIPTHOMEDIR%\log.txt"

Enjoy,

Aeneas of Troy
