data "aws_lb" "nlb" {
   tags = {
    "kubernetes.io/service-name" : "kube-system/nginx-ingress-ingress-nginx-controller"
     #"service.k8s.aws/stack" : "ingress-nginx/ingress-nginx-controller"
   }
}

resource "aws_api_gateway_vpc_link" "vpc_link_eks" {
  name        = "vpc-link-vdlg-eks-cluster"
  target_arns = [data.aws_lb.nlb.arn]
}

resource "aws_api_gateway_rest_api" "rest_api_login" {
   name = "api-gtw-vdlg-login"
   endpoint_configuration {
     types = ["REGIONAL"]
   }
 }

 resource "aws_api_gateway_rest_api" "rest_api_app" {
   name = "api-gtw-vdlg-app"
   endpoint_configuration {
     types = ["REGIONAL"]
   }
 }