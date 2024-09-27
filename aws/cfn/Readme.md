##Architecture Guide

Before you run any templates, be sure to create an S3 bucket to contain all of our artifacts for CloudFormation.

```
aws s3 mk s3://cfn-artifacts-cruddurog10
export CFN_BUCKET="cfn-artifacts-cruddurog10"
gp env CFN_BUCKET="cfn-artifacts-cruddurog10"
```