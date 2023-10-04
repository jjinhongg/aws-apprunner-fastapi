         ___        ______     ____ _                 _  ___  
        / \ \      / / ___|   / ___| | ___  _   _  __| |/ _ \ 
       / _ \ \ /\ / /\___ \  | |   | |/ _ \| | | |/ _` | (_) |
      / ___ \ V  V /  ___) | | |___| | (_) | |_| | (_| |\__, |
     /_/   \_\_/\_/  |____/   \____|_|\___/ \__,_|\__,_|  /_/ 
 ----------------------------------------------------------------- 

# FastAPI + AWS App Runner demo with CI/CD using AWS

## CI/CD (Continuous Integration/Continuous Deployment) outline

1. **Source Control with AWS CodeCommit**:

   Store the code in AWS CodeCommit. Push code changes from AWS Cloud9 to a repository in CodeCommit. To achieve this, I have done the following:
   - Set up AWS Credentials for Cloud9 IAM role. Typically Cloud9 environments inherit permissions from the AWS IAM role they are associated with.
   - Make sure the role has the `AWSCodeCommitFullAccess` policy attached.
   - In my project directory, do `git remote add codecommit <CodeCommit-Repo-URL>` to connect via HTTPS.
   - `git push codecommit master`


2. **Continuous Integration with AWS CodeBuild**:

   - Set up a buildspec file (`buildspec.yml`) in the repository root. This file defines how AWS CodeBuild should run the build process, including installing dependencies, running tests, etc.
   - Create a CodeBuild project and point it to my CodeCommit repository.
   - Configure CodeBuild to use the `buildspec.yml` file to run the build process.

3. **Continuous Deployment with AWS CodePipeline**:

   - Create a pipeline in AWS CodePipeline.
   - Add a source stage that pulls from my CodeCommit repository.
   - Add a build stage that uses my CodeBuild project.
   - For deployment, the steps can vary based on what you're deploying. If you are deploying a web application, for instance, you could use AWS Elastic Beanstalk or AWS Fargate/ECS, or even a serverless deployment with AWS Lambda and API Gateway.
   - Configure the deployment stage to deploy the built code.

4. **Automate the Pipeline**:

   - Every time my code gets pushed to my CodeCommit repository, CodePipeline can automatically trigger, run the tests via CodeBuild, and if tests pass, deploy the application to the chosen AWS service.
 
## Possible extensions
1. **Additional Tools and Enhancements**:

   - You can integrate AWS CodeDeploy if you need more complex deployment strategies like blue/green deployments.
   - To receive notifications on build and deployment activities, you can integrate Amazon SNS.
   - AWS Lambda can be used for custom actions or integrations in your CI/CD pipeline.

2. **Monitor and Logging**:

   - Ensure that AWS CloudWatch is set up to monitor your application's performance and to store logs.
   - Use AWS X-Ray for tracing if you are deploying a microservices architecture or a serverless application.

3. **Secure Your CI/CD**:

   - Ensure all AWS services are correctly configured with the right IAM roles and permissions. Adhere to the principle of least privilege.
   - Regularly review your security groups, VPC configurations, and other networking settings.

Here's a high-level workflow:

1. You make a change in AWS Cloud9 and push it to CodeCommit.
2. CodePipeline detects the change and starts the pipeline.
3. CodeBuild runs the build process as per `buildspec.yml`.
4. If the build (and tests) pass, the deployment stage starts.
5. Your application is deployed to your chosen AWS service.

Remember, while this gives you a CI/CD setup, it's crucial to ensure that everything is appropriately secured, especially if you are deploying production applications. Properly setting up VPCs, security groups, IAM roles, and permissions is crucial. Always review AWS best practices for each service you integrate into your CI/CD process.

## 
