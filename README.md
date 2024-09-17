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

## 更新仓库代码  

```bash
git add . && git commit -m "`date  '+%Y%m%d%H%M'` 更新" && git push -u origin main
```