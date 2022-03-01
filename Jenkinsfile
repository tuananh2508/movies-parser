def dockerImage = 'ta2199/demo-jenkins-movies-parser'
def registry = ''
node ('workers'){
    stage('Checkout'){
        checkout scm
    }

    def imageTest = docker.build("${dockerImage}-test", "-f Dockerfile .")

    stage('QA test'){
        imageTest.inside{
            sh 'golint'
        }
    }

    stage('Unit test'){
        imageTest.inside('-u root:root'){
            sh 'go test'
        }
    }
    
    stage('Security test'){
    	imageTest.inside('-u root:root'){
            sh 'nancy sleuth -p /go/src/github/mlabouardy/movies-parser/Gopkg.lock'
        }
    }

    stage('Build Image'){
        docker.build(dockerImage)
    }

    stage('Push Image'){
        docker.withRegistry('', '8266d0f0-bf5a-495c-bdbf-896e4f36e65c'){
            docker.image(dockerImage).push(commitID())

            if (env.BRANCH_NAME == 'develop'){
                docker.image(dockerImage).push('develop')
            }
        }
    }
}

def commitID(){
    sh 'git rev-parse HEAD > .git/CommitID'
    def commitID = readFile('.git/CommitID').trim()
    sh 'rm .git/CommitID'
    CommitID
}
