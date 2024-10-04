# terraform-ex

## 配置aws认证信息  

```bash
export AWS_ACCESS_KEY_ID=ak
export AWS_SECRET_ACCESS_KEY=sk
```


## 创建s3实例并上传文件  

`terraform apply -auto-approve -target="module.s3_web" -target="null_resource.s3_op"`  

## 删除s3桶中文件并删除桶  

`terraform destroy -auto-approve -target="module.s3_web" -target="null_resource.s3_op"`  

## 查询region中的所有资源  

`aws resourcegroupstaggingapi get-resources --region us-west-1` 


## terraformer的使用  

>https://github.com/GoogleCloudPlatform/terraformer  
### 简介  
基于现有基础设施（反向 Terraform）生成 tf/json 和 tfstate 文件的 CLI 工具。


### terraformer 安装  
`wget https://ghp.ci/https://github.com/GoogleCloudPlatform/terraformer/releases/download/0.8.24/terraformer-all-windows-amd64 -O .bin/terraformer-all-windows-amd64`

### 查看所有aws中支持的所有资源  
`terraformer-all-windows-amd64 import aws list`

### 导出aws中ec2_instance,s3,iam中所有的相关资源到aws目录中    

`.bin/terraformer-all-windows-amd64 import aws -r ec2_instance,s3,iam --regions=us-west-1 -p aws/`

## 更新仓库代码  

```bash
git add . && git commit -m "`date  '+%Y%m%d%H%M'` 更新" && git push -u origin main
```

