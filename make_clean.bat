call delete_eskdi.bat %CD%\example\simple1
call delete_eskdi.bat %CD%\example\simple2
del /s /q *.aux
del /s /q *.toc
del /s /q *.log
del /s /q *.out
del /s /q *.tmp
del /s /q *.exa
del /s /q *.data
del /s /q *-eps-converted-to.pdf
del /s /q .goutputstream*