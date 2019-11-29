@Library('mdblp-library') _

pipeline {
    agent any
    stages {
        stage('Build & Test') { 
             agent {
                dockerfile {
                    filename 'jenkins-build.dockerfile'
                    reuseNode true
                }
            }
            steps { 
                withCredentials([string(credentialsId: 'nexus-token', variable: 'nexus_token')]) {
                    sh 'npm install && npm test'
                    sh 'npm audit --registry=https://registry.npmjs.org --production'
                }
                sh 'sh ./qa/distrib.sh'
                stash name: "distrib", includes: "**"
            }
        }
        stage('Package') {
            steps {
                unstash "distrib"
                pack()
                stash name: "package", includes: "hakken-${GIT_COMMIT}.tar.gz"
            }
        }
        stage('Publish') {
            when { branch "dblp" }
            steps {
                unstash "package"
                publish()
            }
        }
    }
}
