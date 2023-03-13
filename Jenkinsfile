pipeline {
    agent { label any}
    stages {
        stage('Build and Push to local registry') {
            steps {

                dir('example'){
                    git url: 'https://github.com/romanr321/erl_jenkins_example.git'
                    // go inside repo folder
                    dir('example'){
                        sh 'docker-cred-reset'

                        // build docker image
                        sh 'docker build --no-cache -t 10.0.0.109:5000/erl_jenkins_example .'

                        // push docker.las
                        sh 'docker image push 10.0.0.109:5000/erl_jenkins_example'
                        
                        sh 'docker rmi -f 10.0.0.109:5000/erl_jenkins_example '
                    }
                }
            }
        }
    }
    // post {
    //     // changed {
    //     //     // have to use a script block here to get the conditional working
    //     //     script {
    //     //         if (env.BRANCH_NAME == 'master') {
    //     //             // currentBuild.result is null in the case of SUCCESS
    //     //             def result = currentBuild.result ?: 'SUCCESS'
    //     //             slackSend channel:'platform-gateway', message:"${result}: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})"
    //     //         }
    //     //     }
    //     // }
    //     cleanup {
    //         cleanupAgent()
    //     }
    // }
}