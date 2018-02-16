cd ../../
call bundle install
call bundle exec cucumber -t @test1 -f html -o %cd%/test_reports/test1.html -f json -o %cd%/test_reports/test1.json
echo :::::::::::::::::::::::::
echo :::::::::::::::::::::::::
call echo  Please see test results in %cd%/test_reports/test1.html
echo :::::::::::::::::::::::::
echo :::::::::::::::::::::::::
