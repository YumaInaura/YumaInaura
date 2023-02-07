# https://zenn.dev/sway/articles/terraform_biginner_helloworld
resource "local_file" "helloworld" {
    content  = "hello world!"
    filename = "hello.txt"
}
terraform {
    #AWSプロバイダーのバージョン指定
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 4.51.0"
        }
    }
    #tfstateファイルをS3に配置する(配置先のS3は事前に作成済み)
    backend s3 {
        bucket = "terraform-yumainaura"
        region = "ap-northeast-1"
        key    = "tf-test.tfstate"
    }
}

#AWSプロバイダーの定義
provider aws {
    region = "ap-northeast-1"
}

#EC2の作成
# resource aws_instance ec2 {
#     ami           = "ami-0bba69335379e17f8"
#     instance_type = "t2.micro"
#     tags = {
#         Name = "tf-test"
#     }
# }