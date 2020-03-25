pipeline{
    agent any
    tools {
        'org.jenkinsci.plugins.docker.commons.tools.DockerTool' 'docker'
    }
    stages{
        stage("Build Docker Image"){
            steps{
                script {
                    docker.withRegistry("https://docker.io","dockerhub-cred") {
                        docker.withServer("tcp://docker:2376", "docker-client-cert") {
                            def img = docker.build("honnamkuan/sls-gcp-nodejs-agent:1.0.0")
                            img.push()
                        }
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