@echo "Panic Butten was pressed at line 8 train XXX @%time%" >> c:\temp\alert.txt
@"c:\Programs\iSpy\iSpy (64 bit)\VLC64\vlc.exe" c:\temp\horn.mp3 --play-and-exit --qt-start-minimized
@ping 127.0.0.1 -n 2 -w 1000 > NUL
@remark del c:\temp\alert.txt
