cd ../../
SET STARTING_DIR=%cd%
SET DRIVER_LOCATION=%cd%\vendor\drivers\ie\64bit\3.3
call cd %DRIVER_LOCATION% && jar xf IEDriverServer.zip
cd %STARTING_DIR%
call bundle install
SET BROWSER_TYPE=ie
SET HTML_OUTPUT=%cd%/test_reports/%BROWSER_TYPE%_all.html
call bundle exec cucumber %CUCUMBER_TAGS% -f html -o %HTML_OUTPUT% -f json -o %cd%/test_reports/%BROWSER_TYPE%_all.json
set result=%errorlevel%
echo :::::::::::::::::::::::::
echo :::::::::::::::::::::::::
call echo  Please see test results in %HTML_OUTPUT%
echo :::::::::::::::::::::::::
echo :::::::::::::::::::::::::
cd ./ci/batch
taskkill /f /im iexplore.exe
exit /b %result%
