// Jenkins pipeline. Assumes the agent has Python, Node.js, Appium and
// a running Android emulator or device (see README "Running on Jenkins").
pipeline {
    agent any

    parameters {
        choice(name: 'TAGS', choices: ['smoke', 'regression'], description: 'Robot tag to run')
    }

    stages {
        stage('Install') {
            steps {
                sh 'python3 -m venv .venv'
                sh '.venv/bin/pip install -r requirements.txt'
                sh '.venv/bin/python scripts/download_app.py'
            }
        }
        stage('Dry Run') {
            steps {
                sh '.venv/bin/robot --dryrun --outputdir results/dryrun tests'
            }
        }
        stage('Mobile Tests') {
            steps {
                sh 'appium --log appium.log &'
                sh 'sleep 10'
                sh ".venv/bin/robot --include ${params.TAGS} --outputdir results tests"
            }
        }
    }

    post {
        always {
            // Requires the Robot Framework plugin for Jenkins
            robot outputPath: 'results', passThreshold: 100.0, unstableThreshold: 80.0
            archiveArtifacts artifacts: 'results/**, appium.log', allowEmptyArchive: true
        }
    }
}
