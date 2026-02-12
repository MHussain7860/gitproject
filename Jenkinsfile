node {
    def mavenHome = tool name: "maven"
    def imageName = "malikhussain/maven-web-app-jenkins:123"
    stage ("git check out -cloning the code"){
        git branch: 'main', url: 'https://github.com/MHussain7860/maven-webapp-malik.git'
    }
    stage ("Build artifact") {
        sh "${mavenHome}/bin/mvn clean package"
    }
    stage ("Building Docker image") {
        sh "docker --version"
        sh "docker build -t ${imageName} ."
        
    }
  stage ("creating a container") {
    sh "docker stop mvnappbyjenkins || true"
    sh "docker rm mvnappbyjenkins || true"
    sh "docker run -d --name mvnappbyjenkins -p 7070:8080 malikhussain/maven-web-app-jenkins:123"
    sh "docker images"
    sh "docker ps -a"   
}

}

================================================================================================


node {

    def mavenHome = tool name: "maven"
    def imageName = "malikhussain/maven-web-app-devtoqa"
    def imageTag  = "432"
    def qaServer   = "ubuntu@172.31.18.69"

    stage("Git Checkout") {
        git branch: 'main',
            url: 'https://github.com/MHussain7860/maven-webapp-malik.git'
    }

    stage("Build Artifact") {
        sh "${mavenHome}/bin/mvn clean package"
    }

    stage("Build Docker Image") {
        sh "docker build -t ${imageName}:${imageTag} ."
    }

    stage("Docker Hub Login & Push") {
        withCredentials([usernamePassword(
            credentialsId: 'dockerhub-creds',
            usernameVariable: 'DOCKER_USER',
            passwordVariable: 'DOCKER_PASS'
        )]) {
            sh """
              echo \$DOCKER_PASS | docker login -u \$DOCKER_USER --password-stdin
              docker push ${imageName}:${imageTag}
            """
        }
    }

    stage("Deploy to QA Server") {
        sshagent(['qa-server-key']) {
            sh "sh -o StrictHostKeyChecking=no ubuntu@172.31.18.69"
            sh"docker pull ${imageName}:${imageTag}"
            sh "docker stop mvnapp-qa || true"
            sh "docker rm mvnapp-qa || true"
            sh "docker run -d \
                --name mvnapp-qa \
                -p 8084:8080 \
                ${imageName}:${imageTag} "
            sh "docker ps "
            
        }
    }
}

