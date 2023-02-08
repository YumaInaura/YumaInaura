AWS Codepipeline で ECS にデプロイする時の要点

# buildspec.yml

チュートリアル通りのだいたいこんなやつ

```yaml
version: 0.2

phases:
  pre_build:
    commands:
      - echo Logging in to Amazon ECR...
      - aws --version
      - aws ecr get-login-password --region $AWS_DEFAULT_REGION | docker login --username AWS --password-stdin 012345678910.dkr.ecr.us-west-2.amazonaws.com
      - REPOSITORY_URI=012345678910.dkr.ecr.us-west-2.amazonaws.com/hello-world
      - COMMIT_HASH=$(echo $CODEBUILD_RESOLVED_SOURCE_VERSION | cut -c 1-7)
      - IMAGE_TAG=${COMMIT_HASH:=latest}
  build:
    commands:
      - echo Build started on `date`
      - echo Building the Docker image...
      - docker build -t $REPOSITORY_URI:latest .
      - docker tag $REPOSITORY_URI:latest $REPOSITORY_URI:$IMAGE_TAG
  post_build:
    commands:
      - echo Build completed on `date`
      - echo Pushing the Docker images...
      - docker push $REPOSITORY_URI:latest
      - docker push $REPOSITORY_URI:$IMAGE_TAG
      - echo Writing image definitions file...
      - printf '[{"name":"hello-world","imageUri":"%s"}]' $REPOSITORY_URI:$IMAGE_TAG > imagedefinitions.json
artifacts:
    files: imagedefinitions.json
```

# 要点

- `buildspec.yaml` と `Dockerfile` をソースレポジトリに含めておくこと。
- ビルドプロジェクトのサービスロールで `EC2InstanceProfileForImageBuilderECRContainerBuilds` の IAM ポリシーを許可しておくこと。そうしないと
 `aws ecr get-login-password` が失敗する。
- ビルドプロジェクトを作成する時には「特権付与」を有効にすること。そうしないと docker build などのdocker系コマンドが失敗する。 ( `
Docker イメージを構築するか、ビルドで昇格されたアクセス権限を取得するには、このフラグを有効にします` )
- この例のような `buildspec.yml` に書いてある手順は要するにコマンドの羅列に過ぎないので local でも再現できるものが多い。localでも動作確認しながら試すこと。
- `ls` とか `docker pull aplpine` とかいうコマンドも `buildspec.yaml` に書けるのでデバッグ用に仕込んでいくのも良い。
