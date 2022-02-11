# WM_Platform
WM platform exercise

Your task is to build a reusable module for a SPA (Single Page Application) implementation on
AWS. You can use Terraform, CloudFormation, CDK, or SAM. Base requirements:

● It should use S3 for hosting. EC2/ECS should not be used

● It should support a custom domain name

● It should support SSL

● It should support custom WAF rules

● SPA is deployed by pushing static index.html and other web resources

● Bonus: Support a CORS use-case so the website can call an external API gateway (the URL/identity for API gateway can be passed as parameter)

## Design Choices:

![](design/WM.jpg)

1. Domain name reroute done using Route53
2. SSL termination happens at cloudfront where a custom certificate is generated for the domain name and uploaded to cloudfront distribution
3. A WAF ACL is created and attached to the cloudfront distribution
4. SPA is deployed on to a S3 bucket where static web hosting is enabled and the objects are made public
5. A cors rule is added to S3 and the url is passed as the parameter

## Assumptions:
1. The Route 53 hosted zone's nameservers are copied to the respective domain registrars.
2. The acm certificate domain validation is validated by the user manually