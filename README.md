
## Python IRIS Native API in AWS Lambda

If you are looking for a slick way to integrate your IRIS solution in the Amazon Web Services ecosystem, serverless application, or boto3 powered script, using the Python Native API could be the way to go.  You dont have to build out to far with a production implementation until you'll need to reach out and get something or set something in IRIS to make your application do its awesome sauce, so hopefully you will find value in this article and build something that matters or doesnt matter at all to anybody else but you as that is equally important.

If you are looking for some excuses to implement this:

* You need to hit the Pre Token Generation Trigger in Cognito to lookup and stuff the Patient ID context into the token for a SHMAHT on FHIR(R) based solution implenting an OAUTH2 workflow.
* You want to post provision iris tuning settings based on the Instance Type, Node Group, Toaster, or ECS Cluster you fired up to run IRIS on ring zero.
* You want to wow family and friends on Zoom with your management skills of IRIS without your shell ever leaving the AWS cli.

## The Point

Here we are going to provision an AWS lambda function that talks to IRIS and provide some examples on how to provision it, and how to interact with it in various capacities in hopes we can all argue about it and get it published to pip to make things easier.

## In All Cases... 

In the spirit of choose your own adventure, you have three different options which are listed below, but things that are unwavering in all the examples below are:

### Networking

You have IRIS running on anything you want, running in an AWS VPC with exactly two subnets and a security group that allows access to the superserver running IRIS... we use 1972 for nostalgic reasons and for the simple fact InterSystems took the time to register that port with IANA:https://tools.ietf.org/html/rfc6335, and if you add the new port in /etc/services without doing so, you will suffer the same consequences as if you tore the tag off a new mattress.


### Imported Example Class

Somehow, someway, you have managed to inspect and import the ZDEMO.BeNice.ToOneAnother.cls class in the root of this repository into the %SYS namespace on your IRIS instance.

### AWS Access

Get some IAM keys that will allow you to provision and invoke the Lambda Function we are going to change the world with.  Some of the adventures here will use the AWS CLI, python script or terraform, all cases need access to do so.

```
IRIS            [ $$$OK ]  
VPC             [ $$$OK ]  
Subnets         [ $$$OK ]  
Security Group  [ $$$OK ]  
IAM Access      [ $$$OK ]  
Imported Class  [ $$$OK ]  
```

$$$OK, Lesgo.


## Packing up the IRIS Native Python Api for use in Lambda Function

This is the part that would be fantastic if it were a pip package, especially if only for Linux, as AWS Lambda functions execute on Linux boxen.  At the time of this commit, the api is not available via pip, but we are resourceful and can roll our own.

```
mkdir iris_native_lambda
cd iris_native_lambda
wget https://github.com/intersystems/quickstarts-python/raw/master/Solutions/nativeAPI_wheel/irisnative-1.0.0-cp34-abi3-linux_x86_64.whl
unzip nativeAPI_wheel/irisnative-1.0.0-cp34-abi3-linux_x86_64.whl
```

Create your handler, lambda.py, or use the one in the examples folder.

```
cp ../examples/lambda.py .
```

Now zip it up for use.

```
zip -r9 ../iris_native_lambda.zip *
```

Create an S3 bucket, and upload the function zip to it.

```
cd ..
aws s3 mb s3://iris_native_bucket
s3 sync iris_native_lambda.zip s3://iris_native_bucket  
```  
This concludes the packaging of the api and handler for use as an AWS Lambda Function.

Now you can use the console to provision the function in AWS, or choose another adventure below.

## Choose Your Own Adventure

| You are In a Hurry   |      Terraform      |  Cloudformation |
|----------|:-------------:|------:|
| ![in a hurry?](assets/hurry.png) |  left-aligned | $1600 |


### Terraform




### Cloudformation <---- this way tho >>>>>>>

### Execution!
now you can 
```
(base) sween @ basenube-pop-os ~/Desktop/BASENUBE
└─ $ ▶ aws lambda invoke --function-name iris-native-niujpshj --payload '{"method":"Version","args":"none"}' --invocation-type RequestResponse --cli-binary-format raw-in-base64-out --region us-east-2 --profile default /dev/stdout
{{\"status\":1,\"payload\":\"IRIS for UNIX (Red Hat Enterprise Linux for x86-64) 2020.2 (Build 210U) Thu Jun 4 2020 15:48:46 EDT\"}"
    "StatusCode": 200,
    "ExecutedVersion": "$LATEST"
}
```
