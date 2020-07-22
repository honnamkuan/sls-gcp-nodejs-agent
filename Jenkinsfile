
String cron_config = env.BRANCH_NAME == 'master' ? '0 0 1 * *' : ''


pipeline {
    agent any
    tools {
         'org.jenkinsci.plugins.docker.commons.tools.DockerTool' 'docker'
    }
    environment {
        DOCKERHUB_CRED = credentials('dockerhub-cred')
    }
    triggers {
        cron(cron_config)
    }
    options {
        disableConcurrentBuilds()
    }
    stages {
        stage("Build Docker Image") {
            steps {
                script {
                    docker.withServer("tcp://docker:2376", "docker-client-cert") {
                        sh """docker login -u \$DOCKERHUB_CRED_USR -p \$DOCKERHUB_CRED_PSW docker.io
                        docker build --pull -t \$DOCKERHUB_CRED_USR/sls-gcp-nodejs-agent:\$BRANCH_NAME .
                        docker push \$DOCKERHUB_CRED_USR/sls-gcp-nodejs-agent:\$BRANCH_NAME
                        """
                    }
                }
            }
        }
    }

    post {
        success {
            mail to: env.EMAIL_TO, 
                body: "${env.BUILD_URL} completed successfully", 
                subject: "FAIL: ${env.BUILD_TAG}"
        }
        failure {
            mail to: env.EMAIL_TO, 
                body: "${env.BUILD_URL} completed with failure", 
                subject: "SUCCESS: ${env.BUILD_TAG}"
        }
    }
}