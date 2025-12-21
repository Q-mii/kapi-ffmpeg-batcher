ECHO OFF
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
  set "DEL=%%a"
)
cls
echo "          //__//"
echo "   i'm   /   -   \______________ "
echo "  here  /                        \ "
echo "   to  | Y                        \ "
echo "  help  \____/ |                  | "
echo "   ...     __/  \   /___    _     \ "
echo "          //___/ | |    \   | \   / "
echo "                ///     // /  // / "

call :shiny F0 "LET'S ENCODE VARIOUS FILES FOR WEB SHARING"
echo.
call :shiny B0 "ADD f TO ANY SELECTION TO PROCESS A FOLDER"
echo.
echo.
call :shiny 1F "=== WITH AUDIO ==="
echo.
call :shiny 06 "[1 or 2]"
echo  h264 NVENC MP4 (max 1280x720px, ~2mbps or ~5mbps)
echo.
call :shiny 1F "=== WITHOUT AUDIO ==="
echo.
call :shiny 06 "[3 or 4]"
echo  h264 NVENC MP4 (max 1280x720px, ~2mbps or ~5mbps)
echo.
call :shiny 1F "=== AUDIO TOOLS ==="
echo.
call :shiny 06 "[5]"
echo  DUMP AUDIO AS *.WAV
call :shiny 06 "[6]"
echo  REMOVE AUDIO
call :shiny 06 "[7,8,9]"
echo  MAKE *.FLACs, 320kbps *.MP3s, or ~128kbps *.OPUS
echo.
call :shiny 1F "=== SPECIAL USE ==="
echo.
call :shiny 06 "[0]"
echo  AUDIO + IMAGE TO h264 MP4 (2fps, CPU encoding, cue-points ^> chapters)
echo     ^>^> matches audio file with cover.^* image
echo     ^>^> falls back on audio ^> image name match
call :shiny 06 "[x]"
echo  xdd
call :shiny 06 "[t]"
echo  make thumbnails

SET /p op=
IF /i "%op%" == "1" GOTO h264-2
IF /i "%op%" == "1f" GOTO h264-2f
IF /i "%op%" == "2" GOTO h264-5
IF /i "%op%" == "2f" GOTO h264-5f
IF /i "%op%" == "3" GOTO h264-2-na
IF /i "%op%" == "3f" GOTO h264-2-naf
IF /i "%op%" == "4" GOTO h264-5-na
IF /i "%op%" == "4f" GOTO h264-5-naf
IF /i "%op%" == "5" GOTO wav
IF /i "%op%" == "5f" GOTO wavf
IF /i "%op%" == "6" GOTO na
IF /i "%op%" == "6f" GOTO naf
IF /i "%op%" == "7" GOTO flac
IF /i "%op%" == "7f" GOTO flacf
IF /i "%op%" == "8" GOTO mp3
IF /i "%op%" == "8f" GOTO mp3f
IF /i "%op%" == "9" GOTO opus
IF /i "%op%" == "9f" GOTO opusf
IF /i "%op%" == "9d" GOTO opusd
IF /i "%op%" == "0" GOTO track
IF /i "%op%" == "0f" GOTO album
IF /i "%op%" == "x" GOTO xdd
IF /i "%op%" == "xf" GOTO xddf
IF /i "%op%" == "t" GOTO thumb
IF /i "%op%" == "tf" GOTO thumbf
ECHO NOT VALID
GOTO end

:h264-2
for %%i in (%*) do (
ffmpeg -i "%%~i" -vcodec h264_nvenc -b:v 2M -maxrate 2M -bufsize 512K -acodec aac -b:a 192k -vf "scale='min(1280,iw)':min'(720,ih)':force_original_aspect_ratio=decrease" "%%~ni_encode.mp4")
goto end

:h264-2f
cd "%~1"
mkdir output
for %%i in (*.mkv, *.mp4, *.mov, *.avi, *.mxf, *.asf, *.ts, *.vob, *.3gp, *.3g2, *.f4v, *.flv, *.ogv, *.ogx, *.wbm, *.divx) do (
ffmpeg -i "%%~i" -vcodec h264_nvenc -b:v 2M -maxrate 2M -bufsize 512K -acodec aac -b:a 192k -vf "scale='min(1280,iw)':min'(720,ih)':force_original_aspect_ratio=decrease" "output/%%~ni_encode.mp4")
goto end

:h264-5
for %%i in (%*) do (
ffmpeg -i "%%~i" -vcodec h264_nvenc -b:v 5M -maxrate 5M -bufsize 512K -acodec aac -b:a 192k -vf "scale='min(1280,iw)':min'(720,ih)':force_original_aspect_ratio=decrease" "%%~ni_encode.mp4")
goto end

:h264-5f
cd "%~1"
mkdir output
for %%i in (*.mkv, *.mp4, *.mov, *.avi, *.mxf, *.asf, *.ts, *.vob, *.3gp, *.3g2, *.f4v, *.flv, *.ogv, *.ogx, *.wbm, *.divx) do (
ffmpeg -i "%%~i" -vcodec h264_nvenc -b:v 5M -maxrate 5M -bufsize 512K -acodec aac -b:a 192k -vf "scale='min(1280,iw)':min'(720,ih)':force_original_aspect_ratio=decrease" "output/%%~ni_encode.mp4")
goto end

:h264-2-na
for %%i in (%*) do (
ffmpeg -i "%%~i" -vcodec h264_nvenc -b:v 2M -maxrate 2M -bufsize 512K -an  -vf "scale='min(1280,iw)':min'(720,ih)':force_original_aspect_ratio=decrease" "%%~ni_encode.mp4")
goto end

:h264-5-na
for %%i in (%*) do (
ffmpeg -i "%%~i" -vcodec h264_nvenc -b:v 5M -maxrate 5M -bufsize 512K -an -vf "scale='min(1280,iw)':min'(720,ih)':force_original_aspect_ratio=decrease" "%%~ni_encode.mp4")
goto end

:h264-2-naf
cd "%~1"
mkdir output
for %%i in (*.mkv, *.mp4, *.mov, *.avi, *.mxf, *.asf, *.ts, *.vob, *.3gp, *.3g2, *.f4v, *.flv, *.ogv, *.ogx, *.wbm, *.divx) do (
ffmpeg -i "%%~i" -vcodec h264_nvenc -b:v 2M -maxrate 2M -bufsize 512K -an  -vf "scale='min(1280,iw)':min'(720,ih)':force_original_aspect_ratio=decrease" "output/%%~ni_encode.mp4")
goto end

:h264-5-naf
cd "%~1"
mkdir output
for %%i in (*.mkv, *.mp4, *.mov, *.avi, *.mxf, *.asf, *.ts, *.vob, *.3gp, *.3g2, *.f4v, *.flv, *.ogv, *.ogx, *.wbm, *.divx) do (
ffmpeg -i "%%~i" -vcodec h264_nvenc -b:v 5M -maxrate 5M -bufsize 512K -an -vf "scale='min(1280,iw)':min'(720,ih)':force_original_aspect_ratio=decrease" "output/%%~ni_encode.mp4")
goto end

:wav
for %%i in (%*) do (ffmpeg -i "%%~i" -ac 2 -f wav "%%~ni.wav")
goto end

:na
for %%i in (%*) do (ffmpeg -i "%%~i" -c copy -an "%%~ni_noSound%%~xi")
goto end

:wavf
cd "%~1"
mkdir output
for %%i in (*mkv, *.mp4, *.mov, *.avi, *.mxf, *.asf, *.ts, *.vob, *.3gp, *.3g2, *.f4v, *.flv, *.ogv, *.ogx, *.wbm, *.divx) do (ffmpeg -i "%%~i" -ac 2 -f wav "output/%%~ni.wav")
goto end

:naf
cd "%~1"
mkdir output
for %%i in (*mkv, *.mp4, *.mov, *.avi, *.mxf, *.asf, *.ts, *.vob, *.3gp, *.3g2, *.f4v, *.flv, *.ogv, *.ogx, *.wbm, *.divx) do (ffmpeg -i "%%~i" -c copy -an "output/%%~ni_noSound%%~xi")
goto end

:track
IF NOT EXIST "cover.*" (
for %%i IN (%*) do for %%a in (*.jpeg,*.jpg,*.png,*.gif,*.bmp,*.tiff) do if "%%~ni"=="%%~na" (ffmpeg -loop 1 -framerate 2 -i "%%~a" -i "%%~i" -c:v libx264 -preset medium -tune stillimage -crf 18 -c:a aac -b:a 256k -shortest -pix_fmt yuv420p -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" "%%~ni.mp4")
) ELSE (
for %%i IN (%*) do for %%a in (cover.*) do (ffmpeg -loop 1 -framerate 2 -i "%%~a" -i "%%~i" -c:v libx264 -preset medium -tune stillimage -crf 18 -c:a aac -b:a 256k -shortest -pix_fmt yuv420p -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" "%%~ni.mp4"))
)
)
)
goto end

:album
cd "%~1"
IF NOT EXIST "cover.*" (mkdir output
for %%i IN (*.wav,*.mp3,*.flac,*.ogg,*.opus,*.wma,*.aiff,*.aif,*.m4a,*.aac) do for %%a in (*.jpeg,*.jpg,*.png,*.gif,*.bmp,*.tiff) do if "%%~ni"=="%%~na" (ffmpeg -loop 1 -framerate 2 -i "%%~a" -i "%%~i" -c:v libx264 -preset medium -tune stillimage -crf 18 -c:a aac -b:a 256k -shortest -pix_fmt yuv420p -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" "output/%%~ni.mp4")
) ELSE (mkdir output
for %%i IN (*.wav,*.mp3,*.flac,*.ogg,*.opus,*.wma,*.aiff,*.aif,*.m4a,*.aac) do for %%a in (cover.*) do (ffmpeg -loop 1 -framerate 2 -i "%%~a" -i "%%~i" -c:v libx264 -preset medium -tune stillimage -crf 18 -c:a aac -b:a 256k -shortest -pix_fmt yuv420p -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" "output/%%~ni.mp4"))
)
)
)
goto end

:xdd
for %%i in (%*) do (
ffmpeg -i "%%~i" -vcodec h264_nvenc -b:v 48K -maxrate 96K -bufsize 64K -acodec aac -b:a 16k -vf "framerate=fps=8,scale='min(320,iw)':min'(240,ih)',unsharp=5:5:2" "%%~ni_xdd.mp4" -filter_complex "acrusher=level_in=8:level_out=16:bits=8:mode=log:aa=1,alimiter=level_in=1:level_out=0.7:limit=0.3:attack=1:release=1:level=disabled")
goto end

:xddf
cd "%~1"
mkdir output
for %%i in (*.mkv, *.mp4, *.mov, *.avi, *.mxf, *.asf, *.ts, *.vob, *.3gp, *.3g2, *.f4v, *.flv, *.ogv, *.ogx, *.wbm, *.divx) do (
ffmpeg -i "%%~i" -vcodec h264_nvenc -b:v 48K -maxrate 96K -bufsize 64K -acodec aac -b:a 16k -vf "framerate=fps=8,scale='min(320,iw)':min'(240,ih)',unsharp=5:5:2" "%%~ni_xdd.mp4" -filter_complex "acrusher=level_in=8:level_out=16:bits=8:mode=log:aa=1,alimiter=level_in=1:level_out=0.7:limit=0.3:attack=1:release=1:level=disabled")
goto end

:opus
for %%i in (%*) do (ffmpeg -i "%%~i" -c:a libopus -b:a 128k "%%~ni.opus")
goto end

:opusd
for %%i in (%*) do (ffmpeg -i "%%~i" -c:a libopus -b:a 128k "%%~ni.opus"
del "%%~i")
goto end

:opusf
cd "%~1"
mkdir "%~1 [OPUS]"
for %%i IN (*.wav,*.mp3,*.flac,*.ogg,*.opus,*.wma,*.aiff,*.aif,*.m4a,*.aac) do (
ffmpeg -i "%%~i" -c:a libopus -b:a 128k "%~1 [OPUS]\%%~ni.opus")
goto end

:mp3
for %%i in (%*) do (ffmpeg -i "%%~i" -c:a libmp3lame -b:a 320k "%%~ni.mp3")
goto end

:mp3f
cd "%~1"
mkdir "%~1 [MP3]"
for %%i IN (*.wav,*.mp3,*.flac,*.ogg,*.opus,*.wma,*.aiff,*.aif,*.m4a,*.aac) do (
ffmpeg -i "%%~i" -c:a libmp3lame -b:a 320k "%~1 [MP3]\%%~ni.mp3")
goto end

:flac
for %%i in (%*) do (ffmpeg -i "%%~i" -c:a flac "%%~ni.flac")
goto end

:flacf
cd "%~1"
mkdir "%~1 [FLAC]"
for %%i IN (*.wav,*.mp3,*.flac,*.ogg,*.opus,*.wma,*.aiff,*.aif,*.m4a,*.aac) do (
ffmpeg -i "%%~i" -c:a flac "%~1 [FLAC]\%%~ni.flac")
goto end

:thumb
mkdir "thumb"
for %%i in (%*) do (ffmpeg -ss 00:00:05.01 -i "%%~i" -vf "crop=w='min(iw\,ih)':h='min(iw\,ih)',scale=160:160,setsar=1" -frames:v 1 "thumb\%%~ni.png"
pngquant -f --ext .png 16 "thumb\%%~ni.png"
pngout "thumb\%%~ni.png"
)
goto end:end

:thumbf
cd "%~1"
mkdir "thumb"
for %%i in (*) do (ffmpeg -ss 00:00:05.01 -i "%%~i" -vf "crop=w='min(iw\,ih)':h='min(iw\,ih)',scale=160:160,setsar=1" -frames:v 1 "thumb\%%~ni.png"
pngquant -f --ext .png 16 "thumb/%%~ni.png"
pngout "thumb\%%~ni.png"
)
goto end:end

EXIT

:shiny
<nul set /p ".=%DEL%" > "%~2"
findstr /v /a:%1 /R "^$" "%~2" nul
del "%~2" > nul 2>&1
goto :eof