# Week 9 — CI/CD with CodePipeline, CodeBuild and CodeDeploy

**CI/CD with CodePipeline, CodeBuild and CodeDeploy**

We started the week off working with CodePipeline. During the creation of this pipeline, we connect with our Code Repo directly from GitHub. While doing so, Andrew explained that it is good practice to only enable the right project. 

![image](https://github.com/oscarg10/aws-bootcamp-cruddur-2023/assets/56736452/3fe10896-c74a-446c-9064-a5267d0de642)

Additionally, we also created a new branch called ‘prod.’ which is the branch that will be used within CodePipeline. For our deployment provider, we selected ECS but there is a wide variety of options. 

Once we complete the required steps, we create our Pipeline. We noticed that it gets created successfully but the deployment fails because we have not configured it yet. 

![image](https://github.com/oscarg10/aws-bootcamp-cruddur-2023/assets/56736452/28fdf1eb-d6db-4e1a-82a7-f4771a7648b9)

That said, we click edit and then add a stage between source and deploy called ‘bake-image.’ 

![image](https://github.com/oscarg10/aws-bootcamp-cruddur-2023/assets/56736452/bd59f307-6b5f-4516-9cfe-a599cde7bc6c)

Concurrently, we created a CodeBuild Project through our already connected GitHub repo. This build project was going to be connected to CodePipeline. 

![image](https://github.com/oscarg10/aws-bootcamp-cruddur-2023/assets/56736452/b873c6a0-6228-4089-a2aa-df149f79d8b3)

After creating this project, we noticed we were having permission errors while building this project. It seems like it was between the recently created service role, and ECR. 

![image](https://github.com/oscarg10/aws-bootcamp-cruddur-2023/assets/56736452/21d03b22-69cb-4254-9f33-a5d8300aaa98)

Andrew mentioned during one of the latest videos that we didn’t need those to successfully build. However, I had to add an inline policy to the service role in order to have access to ECR. 

![image](https://github.com/oscarg10/aws-bootcamp-cruddur-2023/assets/56736452/f4627a57-93cf-434e-ad47-151c234043d4)

After those were added, we shifted back to CodePipeline and retried executing the pipeline. Good news, all three steps were successful.  

![image](https://github.com/oscarg10/aws-bootcamp-cruddur-2023/assets/56736452/b0b82af3-a0f1-41c6-be2d-21e7da489a79)

This was the last task for Week - 9.
