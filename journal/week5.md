# Week 5 — DynamoDB and Serverless Caching

By far, this has been the most challenging week. It took me completing all the homework challenges, well over 3 weeks. 

I started by watching the LiveStream where DynamoDB was explained and were all the Patterns were laid out and explained before the implementation. I believe that DynamoDB is a very powerful database type. However, it is a little tough to transition from the convetional way of querying (SQL) to a NoSQL. 

Kirk explained very nicely the pros and cons of using DynamoDB and also some best practices when using it. Here are some of my notes from the video itself. 

## Data Modelling LiveStream 

* Preplanning is critical for DynamoDB. The design is very important because it could get expensive or could be implemented wrongly. What data do I need? When do I need it? and How quickly do I need it? 

* Single table design. it is easier to write queries even if we are not using them. The reason being because it help draw a mental map for the table. By the way, partiql let us use SQL queries. 

* Partition Key - It’s an value ID. It’s not necessarily unique. 

* When doing stuff in DynamoDB and create a single table is because all the data is related. Otherwise, create different tables.

* This reduces complexity overtime. Sometimes having many tables could get confusing.

Kirk explained the differences between GLobal Secondary Indexes and Local Secondary Indexes. 

* GSI - Global Secondary Index. It works like creating a different table that is indexed differently. Some fields can use different partition keys.

* LSI - Local Secondary Index. Requires to have the same partition key but the base table. They can be created when you create the base table and it cannot be deleted afterwards.

![image](https://user-images.githubusercontent.com/56736452/230745232-d4dc23d5-9eb0-4758-b83b-2f0a9e2576e9.png)

Additionally, here are some of the patterns used within the direct messaging of our application. 

![image](https://user-images.githubusercontent.com/56736452/230745264-20a32500-89cf-4ca1-828a-ba73fd3fd461.png)

##Implementation. 

The implementation portion of this week was the one that brought me the most roadbumps. I had multiple bugs that definitely taught me how to better debug in future instances. Before I expand on what the problems were, I listed below the different portions of implementation that ran smoothly: 

ddb/schema-load 

![image](https://user-images.githubusercontent.com/56736452/230745519-8316f8ef-2e95-41d5-adba-4eee663a5e69.png)

ddb/seed 

![image](https://user-images.githubusercontent.com/56736452/230745547-6df00988-818a-4fa5-9945-e70303a96ec7.png)

ddb/patterns/get-conversation 

![image](https://user-images.githubusercontent.com/56736452/230745605-5d3d50f2-b315-4664-ae5d-a5f72cb14b49.png)

ddb/patterns/list-conversation 

![image](https://user-images.githubusercontent.com/56736452/230745618-ff2905f3-f073-4868-8a20-db3bbbb308e6.png)

All of the above mentioned, ran as expected when I using the local host. 

My first bug occurred when I was trying to display the seeded data on the actual app interface. I noticed that I was getting a NoneType error, which basically means that a variable/function/ etc. is returning an unexpected value. In this case, it was returning None. After checking all my returns, I noticed that I left an empty return in the messages.py. 

![image](https://user-images.githubusercontent.com/56736452/230745804-7bdcb2d1-16ab-40de-b6ec-df61fd84e315.png)

![image](https://user-images.githubusercontent.com/56736452/230745810-ad89b42a-cd79-4e75-a599-17f7b8bcd3f7.png)

My second bug was very similar to the first one. In this case, when I was trying to type a new message to our new user 'Londo' I was getting an empty handle and an undefined user. I quickly realized that it was another return, but in this case it took me very long to find the empty return. 

![image](https://user-images.githubusercontent.com/56736452/230746029-2337195a-aa56-4c24-923c-0535c1097cce.png)

![image](https://user-images.githubusercontent.com/56736452/230746035-3ae65d97-a207-40ad-b054-3100b1419ca8.png)

Thanks to Andrew, another set of eyes, I was able to go into the users_short.py file and add a 'return results' at the end. 

![image](https://user-images.githubusercontent.com/56736452/230746069-35cc8e01-ed71-4184-99ca-4031a6170550.png)


After I fixed these two bug, the remainder of the implementation went really smooth.

Implementing Lambda and the appropriate permission policies as well as the CLoudWatch logs with no errors can be seen below. 

![image](https://user-images.githubusercontent.com/56736452/230746103-3eb1126d-1004-45a6-bf36-98a7f61acb17.png)

![image](https://user-images.githubusercontent.com/56736452/230746121-e9582208-8ec2-4105-9fa4-8770df108bbf.png)

Finally, see evidence below of the DynamoDB table after being created. 

![image](https://user-images.githubusercontent.com/56736452/230746149-c1dbe09e-a527-43c8-ba5a-5d3d50a2b6cf.png)


## Ashish's Video and Open Up the Cloud Video. 

Ashish provided a very detailed overview of DynamoDB's security best practices. He reinforced the usage of a VPC endpoint to enhance the security of the Database. He also mentioned to user IAM roles to protect the integrity of the data. To apply Read Only access and client side encryption. 

As far as the career in cloud video, I learned about enhancing my resume. The big conclusion here is that we want to show potential hiring managers, that even though we may be lacking cloud professional experience, we can close that gap with previous professional, academic and hands-on (projects) experience. It is also very important to lay it out in a way easy to digest and very cohesive. 





