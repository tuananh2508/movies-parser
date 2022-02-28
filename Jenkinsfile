def dockerImage = 'ta2199/demo-jenkins-movies-parser'

node ('workers'){
    stage('Checkout'){
        checkout scm
    }
    stage('Build Docker Image with QA test'){
        docker.withRegistry('', '8266d0f0-bf5a-495c-bdbf-896e4f36e65c'){
            def imageTest = docker.build("${dockerImage}-test", "-f Dockerfile .")
            imageTest.inside{
                sh 'golint'
            }
        }
    }
}

