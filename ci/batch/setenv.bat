SET STARTING_DIR=%cd%
SET IE_DRIVER_LOCATION=%cd%\vendor\drivers\ie\64bit\3.3
SET FIREFOX_DRIVER_LOCATION=%cd%\vendor\drivers\firefox
SET CHROME_DRIVER_LOCATION=%cd%\vendor\drivers\chrome\64bit\2.29
call cd %IE_DRIVER_LOCATION% && jar xf IEDriverServer.zip
call cd %FIREFOX_DRIVER_LOCATION% && jar xf geckodriver.zip
call cd %CHROME_DRIVER_LOCATION% && jar xf chromedriver.zip
cd %STARTING_DIR%