# Week 2 — Distributed Tracing

##Required Homework 

## Week 2 - Live Stream

Here are some of the highlights from the Live Stream with JessicaÑ 

Distributed Tracing - This is for the backend. When a request goes through different systems we can tell a more comprehensive story. 

![image](https://user-images.githubusercontent.com/56736452/222933225-545885e6-cbf3-4982-95dc-85f85d4ec7f3.png))

Every row is called “span.” For each you can see more details about these actions. For example, the highlighted SQL query expands we can even see the query executed. Additionally, these spans can tell you when those actions occurred. 

![image](https://user-images.githubusercontent.com/56736452/222933238-6cf79dd7-ae33-4a56-8b54-6fc064fe0ea6.png)

By looking at that data, you can determine when this processes can be optimized.

Personal Opinion: This was the first time I heard about Observability and at first glance I believe this is an amazing concept. In fact, this should be implemented accross all industries for better visibility. This can strongly optimize time management and resource allocation as well. 

## Ashish's Video - Observability vs Monitoring

On-premise logs: Infrastructure, Applications, Anti-virus, firewall, etc.

Cloud Logs: Infrastructure, Apps, Anti-virus, Firewall, etc. 

Logging is very time consuming, it carries tons of data with no context for why of the security events? It is basically finding a needle in a haystack. 

Why Observability? Decreased alert fatigue for security operation teams. It looks at the entire lifecycle of a program. It is basically the ability to collect data about a program execution, internal states of modules, and communication between components. 

![image](https://user-images.githubusercontent.com/56736452/222933243-0591c0ad-1748-42ed-80be-851a7deb8e44.png)

Observability in AWS enables users to gather, correlate, aggregate, and analyze telemetry across their network, infrastructure, and applications in the cloud, hybrid, or on-premises environments. This provides users with valuable insights into the behavior, performance, and health of their systems. 

Observability has 3 pillars: Logs, Traces and Metrics

![image](https://user-images.githubusercontent.com/56736452/222933254-4ede247b-c8e0-404f-8b21-3feb6b574637.png)

Instrumentation - is what helps you produce logs, metric or traces. 

![image](https://user-images.githubusercontent.com/56736452/222933259-a64f6394-882b-497b-aee6-a4ada9175b52.png)

Building Security Metrics

1. Identify an application.
    1.  Type of app - compute, monolith, microservice
    2. Threat modeling session 
    3. Identity Attack Vectors 
    4. Map Attack Vectors to TTP in Attack MITRE Framework
    5. Identify instrumentation agents to create tracing (Cloudwatch or Firelens agent, 3rd Party agents) 
    6. AWS services like AWS Distro for OpenTelemetry (ADOT) for metrics and traces 
    7. Dashboard for Practical Attack Vectors only for that application 
    8. Repeat for next app.

#Spend Considerations Video

I watched Chirag's video where he covered free tier infomation about Rollbar, Homeycomb, X-ray and Cloudwatch. 


![image](https://user-images.githubusercontent.com/56736452/222933321-2b11a9f9-84c1-470d-840a-164c04765550.png)


##Implementing Honeycomb 

I was able to implement Honeycomb successfully and obtain traces back from a few events. I was also able to run a combination of queries within the platform. 

![image](https://user-images.githubusercontent.com/56736452/222932892-6001d0d0-1695-4f3d-85a2-f0336789a3fa.png)

##Instrumenting AWS X-RAY

I'm not going to lie, I had some issues instrumenting X-RAY that delay my HW an extra 2 days or so. When trying to create the group, I ran into a security token error (see below) 

![image](https://user-images.githubusercontent.com/56736452/222932952-29c0223d-e6eb-46d8-971f-06ca7ae7ba55.png)

![image](https://user-images.githubusercontent.com/56736452/222932961-3a9b5ea9-ccc3-4e1c-a794-67bb1fcc50da.png)

Googling and asking around, it seems like the problem was with the key saved in Gitpod and my AWS key. However, it seemed that all of those match when I checked them. After trying many different options, I opted to create a new set of keys and start from scratch. It worked. I was not very happy when I couldn't figure out why it was failing to connect, but I guess I was pleased to see that it was resolved after all. 

Once that problem was solved, I was able to implement X-Ray pretty smoothly. By the way, I also commented out X-ray to save on credits. 

![image](https://user-images.githubusercontent.com/56736452/222933056-3b3f2b8e-b4e2-4d5b-8d4f-da008f72e249.png)

![image](https://user-images.githubusercontent.com/56736452/222933057-f5c1eed6-4f72-4dd0-8277-63bf54fa4042.png)

##Instrumenting Cloudwatch 

I'm not going to lie, implementing Cloudwatch was a breeze compared to x-ray. See screenshots below showing logs from the application. 

![image](https://user-images.githubusercontent.com/56736452/222933066-be4cde2f-bdaf-4b5e-be21-16e59148520a.png)

![image](https://user-images.githubusercontent.com/56736452/222933077-c2f47311-2c38-4639-bf37-2e4aca6733f8.png)


##Integrate Rollbar and Capture an error

I was able to follow the steps to integrate rollbar fairly easy and implemented it without any issues. Here is evidence of capturing errors in rollbar. 

![image](https://user-images.githubusercontent.com/56736452/222933169-8774f1fe-8251-4985-b061-e06ef9839d87.png)

![image](https://user-images.githubusercontent.com/56736452/222933171-9abd6ca3-29a9-4580-91ec-8a96c08da3df.png)

![image](https://user-images.githubusercontent.com/56736452/222933176-767c1b4f-b209-4990-9626-f902ad052b1b.png)




