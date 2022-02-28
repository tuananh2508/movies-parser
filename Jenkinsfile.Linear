def dockerImage = 'ta2199/demo-jenkins-movies-parser'

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
            sh 'nancy /go/src/github/mlabouardy/movies-parser/Gopkg.lock'
        }
    }
}



