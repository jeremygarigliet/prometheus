pipeline {
  agent any
  options {
    buildDiscarder logRotator(numToKeepStr: '50')
    disableConcurrentBuilds()
  }
  environment {
    SERVICE = "prometheus"
    REPOSITORY = "jeremygarigliet"
    BRANCH_NAME = "${GIT_BRANCH.split("/")[1].trim()}"
    COMMIT_HASH = "${GIT_COMMIT.take(7)}"
  }
  stages {
    stage('Docker login') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'docker-token', passwordVariable: 'DOCKER_PASS', usernameVariable: 'DOCKER_USER')]) {
          sh '''
            echo ${DOCKER_PASS} | docker login -u ${DOCKER_USER} --password-stdin
          '''
        }
      }
    }
    stage('Build') {
      steps {
        sh '''
          docker build \
            --force-rm \
            -t ${REPOSITORY}/${SERVICE}:latest \
            -t ${REPOSITORY}/${SERVICE}:${BRANCH_NAME} \
            -t ${REPOSITORY}/${SERVICE}:${COMMIT_HASH} .
        '''
      }
    }
    stage('Push') {
      steps {
        sh '''
          docker push ${REPOSITORY}/${SERVICE}:latest
          docker push ${REPOSITORY}/${SERVICE}:${BRANCH_NAME}
          docker push ${REPOSITORY}/${SERVICE}:${COMMIT_HASH}
        '''
      }
    }
  }
  post {
    always {
      cleanWs()
      echo "All becomes one when the sun comes to earth."
    }
  }
}
