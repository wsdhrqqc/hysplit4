

for %%i in (D:\hysplit4\working\input\*.TXT) do (
copy %%i D:\hysplit4\working\CONTROL
D:\hysplit4\exec\hyts_std.exe
)
