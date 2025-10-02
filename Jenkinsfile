pipeline{
    agent {label "prod"}
    
    stages{
        stage("code clone"){
            steps{
                git url: "https://github.com/Manthan0501/online_shop.git", branch: "Hackathon"
        }
    }
    stage("code build"){
        steps{
        sh "docker build -t online-shop:latest ."
        }
    }
    stage("push to docker hub"){
        steps{
            withCredentials([usernamePassword(
                credentialsId:"docker-hub-cred",
                passwordVariable: "password",
                usernameVariable: "username"
                )]){
                    sh "docker login -u ${env.username} -p ${env.password}"
                    sh "docker image tag online-shop:latest ${env.username}/online-shop:latest"
                    sh "docker push ${env.username}/online-shop:latest"
                }
        }
    }
    stage("code deployment"){
        steps{
            sh "kubectl apply -f k8s/deployment.yml"
        }
    }
    stage("code serve"){
        steps{
            sh "kubectl apply -f k8s/service.yml"
        }
    }
    stage("port forward"){
        steps{
            sh "nohup sudo -E kubectl port-forward svc/online-shop-svc -n online-shop 2000:80 --address=0.0.0.0 >/dev/null 2>&1 &"
        }
    }
}
}
