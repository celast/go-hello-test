node {
    env.IMAGE = 'go-test-hello'
    env.DOCKERFILE = 'Dockerfile'
    env.CONTAINER_NAME = 'go-hello'

    stage('checkout codes') { // for display purposes
        echo 'check codes start ...'
        checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/celast/go-hello-test.git']]])
    }
    stage('building image') {
        echo 'building image ...'
        sh '''
        #!/bin/bash
        docker build -f ${env.DOCKERFILE} -t ${env.IMAGE} .
        '''
    }
    stage('run image') {
        echo 'running image ...'
        sh '''
        #!/bin/bash
        docker run --rm --name ${env.CONTAINER_NAME} ${env.IMAGE}
        '''
    }
    stage('test ssh') {
        echo 'testing ssh ...'
        sshagent(['ea3bd256-b9de-4c0f-a0f6-5eb6fd3fd6bc']) {
            sh '''
            #!/bin/bash
            docker pull hello-world
            '''
        }
    }
    stage('done') {
        echo 'all done'
    }
}