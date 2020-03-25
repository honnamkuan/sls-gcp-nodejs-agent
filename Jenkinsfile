pipeline{
    agent any
    stages{
        stage("Build Docker Image"){
            steps{
                script {
                    docker.withRegistry("https://docker.io") {
                        def img = docker.build("honnamkuan/sls-gcp-nodejs-agent:1.0.0")
                        img.push()
                    }
                }
            }
            post{
                always{
                    echo "========always========"
                }
                success{
                    echo "========A executed successfully========"
                }
                failure{
                    echo "========A execution failed========"
                }
            }
        }
    }
    post{
        always{
            echo "========always========"
        }
        success{
            echo "========pipeline executed successfully ========"
        }
        failure{
            echo "========pipeline execution failed========"
        }
    }
}