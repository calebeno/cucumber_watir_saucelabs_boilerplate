cd ../../
SET STARTING_DIR=%cd%
SET DRIVER_LOCATION=%cd%\vendor\drivers\chrome\64bit\2.29
call cd %DRIVER_LOCATION% && jar xf chromedriver.zip
cd %STARTING_DIR%
call bundle install
SET BROWSER_TYPE=chrome
SET HTML_OUTPUT=%cd%/test_reports/%BROWSER_TYPE%_all.html
call bundle exec cucumber %CUCUMBER_TAGS% -f html -o %HTML_OUTPUT% -f json -o %cd%/test_reports/%BROWSER_TYPE%_all.json
set result=%errorlevel%
echo :::::::::::::::::::::::::
echo :::::::::::::::::::::::::
call echo  Please see test results in %HTML_OUTPUT%
echo :::::::::::::::::::::::::
echo :::::::::::::::::::::::::
cd ./ci/batch
exit /b %result%