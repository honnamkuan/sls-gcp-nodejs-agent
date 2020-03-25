pipeline{
    agent any
    tools {
         'org.jenkinsci.plugins.docker.commons.tools.DockerTool' 'docker'
    }
    environment {
        DOCKERHUB_CRED = credentials('dockerhub-cred')
    }
    stages{
        stage("Build Docker Image"){
            steps{
                script {
                    docker.withServer("tcp://docker:2376", "docker-client-cert") {
                        sh 'docker login -u \$DOCKERHUB_CRED_USR -p \$DOCKERHUB_CRED_PSW docker.io'
                        def img = docker.build("honnamkuan/sls-gcp-nodejs-agent:latest")
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