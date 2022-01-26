node {
    env.image = 'go-test-hello'
    env.dockerfile = 'Dockerfile'

    stage('checkout codes') { // for display purposes
        echo 'check codes start ...'
        checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/celast/go-hello-test.git']]])
    }
    stage('building image') {
        echo 'building image ...'
        sh '''
        #!/bin/bash
        docker build -f $dockerfile -t $image .
        '''
    }
    stage('run image') {
        echo 'running image ...'
        sh '''
        #!/bin/bash
        docker run --rm -it --name go-test-hello $image
        '''
    }
    stage('test ssh') {
        echo 'testing image ...'
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