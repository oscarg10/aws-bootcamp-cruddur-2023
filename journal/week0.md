# Week 0 — Billing and Architecture

## Live Lecture February 11th, 2023

### Business Case 


Tony - Hiring Manager

Sam - Owner of the startup 

We got hired by startup company in which we will be in charged of the application development and the implementation of AWS services to scale this application. There is a considerable amount of pressure because the company has a limited budget. The investors are also looking to see a finished product that can reach a bigger amount of users. 

As part of the introduction, we learned that a Monolithic Application is a big one unit that has all its components tied to each other. Everything is condensed in one place. We are trying to build a microservice, which means that we will need to decouple those components. We want to separate User Interface, Business logic and Data access. 

As a side note - We always got to consider the triangle below. Why? Because this is what needs to be explain to upper management when they are requesting a project. When lacking money, then they cannot expect something cheap but also high quality and fast. 

![](images/2023-02-14-21-50-21.png)

We also need to be mindful of budget when spending in infrastructure. As mentioned above, budget is a little tight.  

![](images/2023-02-14-21-50-53.png)
![](images/2023-02-14-21-51-08.png)

### Technical Architecture - Chris' Portion 

Meet the requirements - Assess requirements, so go over risks, assumptions and constraints, etc. 

- These need to be verifiable, monitorable, traceable, and feasible.

![](images/2023-02-14-21-52-10.png)

For these type of projects, it is important to do the following: 

- Ask “dumb questions”
- play be-the-packet - Think as a data packet and how it travels through the infrastructure. It will be easier to understand what the system is lacking.
- Document everything - Specially adding comments to pieces of code. Many non-technical people should be able to understand what is going on.

![](images/2023-02-14-21-53-04.png)

![](images/2023-02-14-21-53-33.png)

### Pre-built diagram

Logical Architecture 

![](images/2023-02-14-21-53-58.png)

## Creating Billing Alerts

- When creating an alert, it is very important to be on the N. Virginia Region. Otherwise, Billing data won’t show.
- It is good practice to use tags so it is easier to figure out what exact resource is spending the most. It is another way to have more granular data.
    - These tags could be regions, owners, environments, etc.



## Required Homework for week 0 : 

1. Set a Billing alarm - Dollar amount. 

Added billing alert using Cloudwatch. Set up the alarm so it would send me an email in case the 80% of my budget was reached.   

![Billing Alert](images/2023-02-13-21-02-15.png)


2. Create an AWS Budget - Credits with an 80% threshold alert. 

Very similar to the billing alert, I created a $10 budget that will notify me if I go past 80% of it. 


![Budget Screenshot 1](images/2023-02-12-14-50-27.png)
![Budget Screenshot 2](images/2023-02-12-14-51-01.png)

3. Activating MFA in a new user created. Also, added policies to the new admin account

![Proof of MFA](images/2023-02-12-14-53-08.png)
![Admin User](images/2023-02-12-14-54-03.png)
![Policies Added to User](images/2023-02-12-14-54-59.png)

4. Watched Ashish Rajan Cloud Security Best Practices video 

![](images/2023-02-13-22-06-50.png)

5. Installed AWS CLI, used Cloudshell and created an Admin User. 

I had previously installed AWS CLI using the Windows commands. As evidence, I pasted a screenshot of my AWS credentials and also a screenshot of the current AWS CLI version installed on my local machine. 

![aws cli version](images/2023-02-14-22-06-45.png)

![aws-sts](images/2023-02-15-21-43-36.png)

![Cloudshell](images/2023-02-14-22-13-01.png)

![Admin User](images/2023-02-14-22-10-03.png)

6. Logical Diagram in Lucid

Here is the link of the diagram along with a screenshot below: [Logical Diagram](https://lucid.app/lucidchart/a95a435a-8f70-40df-89c3-283f63c96fea/edit?viewport_loc=-336%2C-252%2C2994%2C1423%2C0_0&invitationId=inv_60bf124b-1548-4d62-bc7e-4d63f98e3344)

![Logical Diagram Screenshot](images/2023-02-15-18-54-22.png)

7. Conceptual Diagram in Lucid and Napkin

Here is the link of the diagram along with a screenshot below: [Conceptual Diagram](https://lucid.app/lucidchart/b1450513-c409-4cda-930f-91e76050f2f1/edit?viewport_loc=-783%2C-584%2C3700%2C1759%2C0_0&invitationId=inv_01b8ef66-2b65-4842-bf4e-26868dd155d4)

![Lucid Diagram](images/2023-02-15-19-01-59.png)
![Napkin Diagram](images/2023-02-15-19-13-04.png)

## Homework Challenges 

Created a workflow within the AWS Well-Architected tool with the idea to be more familiar with the questions: 

![Well-Architected 1](images/2023-02-15-22-11-24.png)

I noticed that within the tool, on the right hand side, AWS provides helpful resources that may guide you to the appropriate answers for each question: 

![Helful Resources](images/2023-02-15-22-13-09.png)

Additionally, AWS give the option to ask an expert in case we need assistance with any of these questions. There is a button under each section title called "Ask an expert" that will redirect users to a knowledge center where there are FAQs from recent users, experts, and there is also the possibility to start a conversation with an AWS expert: 

![Ask an expert](images/2023-02-15-22-16-07.png)
![Knowledge Center](images/2023-02-15-22-16-24.png)
## AWS Security Best Practices Video

As part of the homework exercise, I wanted to summarize the most important points that Ashish covered during his lecture. First of all, the video was really easy to follow and understand. That said, here is what I got out of it. 

Cloud Security - Cybersecurity that protects the data, apps and services associated to the cloud. 

- We should care to reduce impact of breaches. Also, to protect assets hosted in the cloud.

### Adding MFA to Root Account

This is very important because the “Root User” is the most powerful user in your AWS environment. If the root account gets compromised, then it’s game over. 

### Create an Org Unit

With this option, users can create multiple accounts using AWS Organizations. This was a great option to segregate the accounts and improved security. 

### Enabling CloudTrail

Cloudtrail is an auditing service. It monitors data security and residence. For this service, we need to understand the region vs AZs vs Global services concepts. For example, if you are tracking services using Cloudtrail, it is important to track the appropriate regions. Otherwise, those won’t be recorded. 

### Create IAM User

There are 3 kinds of user in AWS. When creating these users, the principle of least privilege should be applied. This principle basically helps giving users the appropriate level of access. Instead of giving full access to all the accounts, we need to make sure users get the right access to the right services. Along these lines, MFA should be enabled to all of the accounts as best practice. 

### IAM Roles

It is important to understand the difference between IAM roles and policies. Roles are the permission assigned directly to AWS services. Now, policies can be attached to a group of users or organizations. To reiterate, it is always good practice to apply the principle of least privilege. 

### Enable AWS Organization SCP

These are a type of organization policies that can be used to manage permissions in the organizations. The advantage of this is the centralization of managing permissions. For this option, it is really important to understand the share responsibility model.

### Summary - Security Best Practices

1. Data protection and Residency in accordance to Security Policy
2. IAM with least privilege 
3. Governance and Compliance of AWS Services being used
    a. Global vs Regional Services
    b. Compliant Services
4. Shared Responsibility of Threat Detection. 
5. Incident Response plans to include Cloud