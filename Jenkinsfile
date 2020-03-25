pipeline{
    agent any
    tools {
         'org.jenkinsci.plugins.docker.commons.tools.DockerTool' 'docker'
    }
    environment {
        DOCKERHUB_CRED = credentials('dockerhub-cred')
    }
    stages {
        stage("Build Docker Image") {
            steps {
                script {
                    docker.withServer("tcp://docker:2376", "docker-client-cert") {
                        sh """docker login -u \$DOCKERHUB_CRED_USR -p \$DOCKERHUB_CRED_PSW docker.io
                        docker build --pull -t honnamkuan/sls-gcp-nodejs-agent:latest .
                        docker push
                        """
                    }
                }
            }
        }
    }
}