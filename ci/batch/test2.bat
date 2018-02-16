cd ../../
call bundle install
call bundle exec cucumber -t @test2 -f html -o %cd%/test_reports/test2.html -f json -o %cd%/test_reports/test2.json
echo :::::::::::::::::::::::::
echo :::::::::::::::::::::::::
call echo  Please see test results in %cd%/test_reports/test2.html
echo :::::::::::::::::::::::::
echo :::::::::::::::::::::::::
