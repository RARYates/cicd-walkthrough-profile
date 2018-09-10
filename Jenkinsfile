pipeline {
    agent any

    stages {
        stage('Validate') {
            steps {
                sh '/usr/local/bin/pdk validate'
            }
        }
        stage ('Unit Test') {
            steps {
                sh '/usr/local/bin/pdk test unit'
             }
        }
    }
}
