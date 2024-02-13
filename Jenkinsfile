pipeline {
    agent {
        label 'FRONTEND'
    }

    options {
        ansiColor('xterm')
    }

    parameters {
        string(name: 'REVISION', defaultValue: '2.29.0', description: 'OpenVidu-Call version to build')
    }

    environment {
        CLOUDSDK_CORE_PROJECT = 'pure-quasar-407114'
        CLOUDSDK_REGION = 'europe-west6'
        GOOGLE_CREDENTIALS = credentials('gcp-credentials')
    }

    stages {
        stage('Initialise gcloud') {
            steps {
                withCredentials([file(credentialsId: 'gcp-credentials', variable: 'GCP_KEY')]) {
                    sh 'gcloud auth activate-service-account --key-file=${GCP_KEY}'
                    sh 'podman login -u _json_key --password-stdin ${CLOUDSDK_REGION}-docker.pkg.dev < ${GCP_KEY}'
                }
            }
        }

        stage('Build docker image') {
            when {
                expression {
                    return false
                }
            }

            steps {
                sh "cd docker && ./create_image.sh ${params.REVISION}"
            }
        }

        stage('Push image to registry') {
            when {
                expression {
                    return false
                }
            }

            steps {
                sh "podman push ${CLOUDSDK_REGION}-docker.pkg.dev/${CLOUDSDK_CORE_PROJECT}/docdok-registry/openvidu-call:${params.REVISION}"
            }
        }
    }
}
