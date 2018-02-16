#!groovy
properties(
        [
                [
                        $class  : 'BuildDiscarderProperty',
                        strategy: [$class: 'LogRotator', numToKeepStr: '10']
                ],
                [
                        $class              : 'ParametersDefinitionProperty',
                        parameterDefinitions: [
                                [$class      : 'StringParameterDefinition',
                                 defaultValue: '-t ~@fail_on_purpose', description: '',
                                 name        : 'CUCUMBER_TAGS'],
                                [$class      : 'StringParameterDefinition',
                                 defaultValue: 'develop', description: '',
                                 name        : 'BRANCH'],
                        ]
                ]
        ]
)

node('windows') {
    deleteDir()
    stage('Pull from SCM') {
        try {
            checkout scm
        }
        catch (error) {
            echo 'Failed to pull from SCM.  Attempting one additional time'
            sleep 5
            checkout scm
        }
    }
    executeScenarios();
}

def executeScenarios() {
    Exception testFailed;
    parallel firstBranch: {
        try {
            stage('Execute Chrome Tests') {
                dir('ci/batch') {
                    bat 'chrome_all.bat'
                }
            }
        }
        catch (Exception e) {
            testFailed = e;
        }
    }, secondBranch: {
        try {
            stage('Execute Firefox Tests') {
                dir('ci/batch') {
                    bat 'firefox_all.bat'
                }
            }
        }
        catch (Exception e) {
            testFailed = e;
        }
    }
    failFast: false
    stage('Archive Artifacts') {
           archiveArtifacts 'test_reports/**/*'
    }

    if (testFailed != null) {
        throw testFailed;
    }
}