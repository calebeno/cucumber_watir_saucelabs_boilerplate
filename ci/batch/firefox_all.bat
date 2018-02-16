cd ../../
SET STARTING_DIR=%cd%
SET DRIVER_LOCATION=%cd%\vendor\drivers\firefox
call cd %DRIVER_LOCATION% && jar xf geckodriver.zip
cd %STARTING_DIR%
call bundle install
SET BROWSER_TYPE=firefox
SET HTML_OUTPUT=%cd%/test_reports/firefox_all.html
call bundle exec cucumber %CUCUMBER_TAGS% -f html -o %HTML_OUTPUT% -f json -o %cd%/test_reports/firefox_all.json
set result=%errorlevel%
echo :::::::::::::::::::::::::
echo :::::::::::::::::::::::::
call echo  Please see test results in %HTML_OUTPUT%
echo :::::::::::::::::::::::::
echo :::::::::::::::::::::::::
cd ./ci/batch
taskkill /f /im firefox.exe
exit /b %result%
