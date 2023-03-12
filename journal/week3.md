# Week 3 — Decentralized Authentication

##Required Homework

### Setup Cognito User Pool

I was able to successfully create an User Pool through AWS interface. Following Andrew's video, we ran into issues with the user pool configurations, so we had to create User Pool a few times. Besides that, there were no issues interacting with this portion of Cognito. The process of creating the env vars with the Client ID was fairly straight forward as well. 

![image](https://user-images.githubusercontent.com/56736452/224562012-901dcff1-6a24-4a55-9537-e3bf9aff22a9.png)

![image](https://user-images.githubusercontent.com/56736452/224562128-24a23759-c4f4-4fe9-8131-3c1a47b88d17.png)

Once that was created, I was able to implement the custom signin page which will capture the users information and keep it within Cognito. For this process, I replace the existing code within the Signin js file to where instead of using cookies, it will capture the user's information and record it within Cognito for future authentication. This was using AWS amplify. 

![image](https://user-images.githubusercontent.com/56736452/224562188-379cd1a5-3e0f-491f-9883-2086bd0ef408.png)

![image](https://user-images.githubusercontent.com/56736452/224562765-677f89c5-a74b-40cf-af66-3679d66ea476.png)

![image](https://user-images.githubusercontent.com/56736452/224562339-da87dda4-a8a4-4af0-9c95-ef48bca5ac77.png)


Similarly to the Signin page, I modified the SignUp js file to use real data rather than hard coded data using cookies. 


![image](https://user-images.githubusercontent.com/56736452/224562474-9121f0f9-bdcd-4898-a7aa-194e488881e9.png)


After an user signs up, it will require them to confirm the email address by sending a confirmation code. I knew code was implemented correctly once I received the confirmation number. 

![image](https://user-images.githubusercontent.com/56736452/224562601-ed44e2aa-1ed5-4849-a181-355ccfc473be.png)

Once that step was completed, the recovery page needed a similar step where code that was utilizing cookies had to be replace with the amplify snipped referenced above. In case you need to create a new password, this page will request an email address and then it will send a verification code to that email. The same confirmation number referenced in the screenshot above. 

![image](https://user-images.githubusercontent.com/56736452/224562731-1e700639-ef8d-4f4c-9e4b-f0be17b255e0.png)

Finally, I implemented JWTs verification. Now, going through this process, I ran into all sorts of roadbumps that slowed me down substantially. Out of all the errors that I was running into, I only captured the last one because that took me the most time. Looking back, this was probably the easiest one to solve yet it took longer. 

I was getting messages that my application was not able to fetch any data. I quickly realized that there was a disconnect between the front-end and the back-end. What threw me off a bit was the fact that the error message was referencing a block by a CORS Policy. Unfortunaly, I took the wrong approach that lead me to wasting a long time debugging something that was not broken. I started looking at the headers within the app.py and all the js files where those were being used. 

![image](https://user-images.githubusercontent.com/56736452/224563035-de241482-7c4a-401a-8d3e-51dea8d83e8b.png)

After a frustrating and unsuccessful search for the problem, I reopened the backend docker logs and saw a message that gave me hope: "aws_xray_sdk.core.exceptions...**SegmentNotFoundException**." After seeing that, I commented out all the xray code I had within app.py which eventually solved the 500 error I was getting.  

![image](https://user-images.githubusercontent.com/56736452/224563024-a949637d-a06a-4973-b1b5-8a0518831f10.png)

I feels so great solving this type of hiccups. Anyway, after having the app working again. I followed the CSS video to improve the UI a little bit more. Here is the result of the new view. 

![image](https://user-images.githubusercontent.com/56736452/224563444-0dd65580-2a41-4d2b-8ae9-e80fef2fe859.png)

![image](https://user-images.githubusercontent.com/56736452/224563461-b6c0035c-cb3d-494c-8a4c-40ee54014af9.png)

Also, I watched Ahish's security considerations for the decentralzied authentication through Cognito. 






