# Week 6 — Deploying Containers

Started week 6 provisioning an ECS Cluster named Cruddur which then will be the Cluster housing the Frontend and Backend images. To do this, an ECR repository had to be created because this is where we were going to push our container images. 

![image](https://user-images.githubusercontent.com/56736452/235392694-7ef800ad-173f-4a8b-a158-c2ecf5825ddb.png)


![image](https://user-images.githubusercontent.com/56736452/235392780-8b589eba-9578-4cc5-ac82-120707d7f2a8.png)

At the beginning of the provisioning process, we were directly inputting commands to login, build, deploy and push images to the console. In the long run, this process becomes very time-consuming and annoying. Therefore, we decided to create bash scripts with the same commands that will help us save time when dealing with container images. 

![image](https://user-images.githubusercontent.com/56736452/235393258-daaa7d26-3642-46fc-afe1-d70a2e19316b.png) ![image](https://user-images.githubusercontent.com/56736452/235393284-533aed07-ece9-4d84-a9c4-224cac0169ce.png)

To run a docker container on ECS, it is required to create task definitions with specific paramenters for the container images. We started with the back end file where we define the CPU, memory, port mappings, log configuration, environment and secrets. Within the secrets, we added the AWS keys as environment variables so they are not public. Additionally, a health check definition was added which then will tell us whether the image is healthy when it's deployed or if it had any issues when it was created. 

![image](https://user-images.githubusercontent.com/56736452/235393970-7bf8d586-2cf6-407c-88b6-0cdbbadbc42e.png)

The frontend task definition is very similar, except for the port values and other details that were not needed. Another important thing to note is that that we added VPC during this process as seen in the image above. This will enable us to only add the port values. We will then name our port mappings because we will be using Service Connect which is a service that provides management of service-to-service communication as part of ECS configs. 

During this process, the idea was to configure a Load Balancer along with terget groups. We configured our target groups adding the same ports mapped to our frontend and backend. As mentioned previously, the implementantion of the health checks were also noticeable during this process since we could add the different targets. 

![image](https://user-images.githubusercontent.com/56736452/235395067-5dc0467b-e9b5-48a9-98c3-139a78421128.png)

![image](https://user-images.githubusercontent.com/56736452/235395109-1b7ab461-d493-4b55-96ec-10e0001907b1.png)

![image](https://user-images.githubusercontent.com/56736452/235397528-fe80200d-de23-4cc1-9f02-b2430bd297f6.png)

![image](https://user-images.githubusercontent.com/56736452/235395175-479b5395-f951-4dd8-912a-834863b8b06d.png)


At this point, we were really close to deploy our app using our customed domain but before doing so we had to link an SSL certificate. The mentioned certificate is the one that will provide trust to the browser and confirm that we own the domain that we have in control. This practice will then allow our users to verify that our website is legitimate and the connection is secure. 

![image](https://user-images.githubusercontent.com/56736452/235395470-65f46ff0-c2a9-4d19-b9bf-070e0aeede37.png)

This process takes a couple of mins-hrs while the certificate gets validated. However, my initial domain was taking too long so I decided to purchase a different certificate through AWS. Once I did that, the validation process took a few minutes. 

![image](https://user-images.githubusercontent.com/56736452/235395604-c918644f-6f80-427c-a5a9-087292da8dc8.png)


After getting the certificate, I proceeded to register my domain within Route 53 for hosting. 

![image](https://user-images.githubusercontent.com/56736452/235395745-357ae2cc-2b16-4249-8760-e71b2ea43001.png)


![image](https://user-images.githubusercontent.com/56736452/235395956-11cbceca-f964-41bc-a252-2336c05705f4.png)

Once images were deployed and the domain was added to route 53, the site was visible. 

![image](https://user-images.githubusercontent.com/56736452/235396133-85a16976-3994-4222-bd06-e837634caf8e.png)

Obviously, this did not go as smooth as it sounds. We ran into a wide variety of bugs during the implementation. Some bugs were due to missing return statements (hate those), some others were due to CORS (also hate those). A very interesting bug that rattled me for a couple of nights was that when trying to docker compose up our local environment, it will never show the ports available. I tried a million things and then realized that a bunch of bootcampers were running into the same problem. After further investigating, we found out that this is a GitPod bug and they currently have a ticket open. 


![image](https://user-images.githubusercontent.com/56736452/235396592-46e62c3a-9e93-4acf-992d-39462706679a.png)

Towards the end of the implementation, Andrew created two Ruby files that will output our env vars in another file which then will be used by one of our bash scripts for docker.


Overall, this was the core purpose of week 6-7. Now, we definitely spent some time sharpening other components within the application like fixing the messaging within the production environment, we also updated our code so we did not have to login every 10 minutes, and we also corrected the timezone innacuracies. 

![image](https://user-images.githubusercontent.com/56736452/235397191-94d704d4-ada6-4e25-b427-aae176f4c613.png)

After seeing all these roadblocks, it was only fair to configure x-ray and container insights within our task definitions so we have more tools to debug in future opportunities. 

##Fargate Technical Questions with Maish

First of all, shotout to Maish for being part of this Bootcamp and adding his very valuable knowledge. This video helped clarify a bunch of questions and solidify the understanding of core container concepts. Here are a couple of highltightsI wrote during the video: 

When using a container how many processes need/can be running at the same time? Single process per container. The idea is to scale out and having multiple processes will limit that capability

- Container is the access of 1 CPU. How many CPU cycle are you getting per container. It is critical when using Fargate.
- For fargate - AWS handles all security that runs under the operating system. Now, when using EC2 the customer is responsible for patching and such. There are services that could help, but we need to keep our containers very concise and secure.
- Fargate you can only use VPC mode. ENI. Maybe review Service Connect.

## Security Video with Ashish

As always, Ashish touched really good points about the security for ECS. Ashish repeated that access controls are always critical when using the different serivices within AWS to have a control environment. For containers, he recommended using VPC endpoints or Security Groups. Logging was another relevant service to have when working with containers. 







