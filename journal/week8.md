# Week 8 — Serverless Image Processing

# Serverless Image Process

Add the cdk into gitpod.yml so it starts everytime we spin up a new instance. Once add it to the .yaml, we need to npm install aws-cdk. To test it, we need to run 

```jsx
cdk deploy
```

 

We have to add the env vars into a .env file. To keep in mind - we want to name these vars “{name}.cruddurog-10.com.” The reason being that this is the format required by Cloudformation.

![image](https://github.com/oscarg10/aws-bootcamp-cruddur-2023/assets/56736452/1cae4ecd-f7b4-4118-8fcb-77ec68d4cca1)

 Then we need to create a ‘process-images’ folder to keep our images. Once that is done, we proceeded to establish our env vars. 

![image](https://github.com/oscarg10/aws-bootcamp-cruddur-2023/assets/56736452/ee849a11-3e27-492f-906d-8c30dc98c6e8)


Even after running these commands, we were yet to deploy it because the thumbing path (”process-images”) is still empty. For that, we have to copy the contents from the wee-8-serverless branch. 

Now, we have to install our sdk libraries.  

```jsx
npm i @aws-sdk/client-s3
```

We also need to ass “node_modules” to the .gitignore. Once that is done, we can do ```cdk deploy```. After that step is completed, we should be able to create the Lambda. 

For AWS Lambda, the node_modules directory of the deployment package for sharps must include binaries for the Linux x64 platform. We need to run the following command after npm install 

```jsx
npm install
rm -rf node_modules/sharp
SHARP_IGNORE_GLOBAL_LIBVIPS=1 npm install --arch=x64 --platform=linux --libc=glibc sharp
```

- Create a new ‘serverless’ file inside of bin and paste the snipped above to have it as a bash script. Reference Andrew’s GitHub. Also, remember to chmod the bash script

### Create S3 Event Notification to Lambda

![image](https://github.com/oscarg10/aws-bootcamp-cruddur-2023/assets/56736452/91d8917d-f374-4525-9294-a60af286669a)

After adding this code, we need to cdk synth to confirm everything is okay before running cdk deploy 

- For the bucket arn issue, we decided to import the bucket to the thumbing file.

Create folders within our S3 bucket and add a .jpeg image. Preferably we will do it through the CLI by creating an upload bsah script.  

Also, as a clean up process, we tweaked the fargate command in the gitpod.yml to get rid of the sessions manager plugin file. 

![image](https://github.com/oscarg10/aws-bootcamp-cruddur-2023/assets/56736452/f310e714-901f-41e1-b4d7-2cdb588f49e5)

### Implementation

![image](https://github.com/oscarg10/aws-bootcamp-cruddur-2023/assets/56736452/d9862004-d177-4e1f-947f-10a745e7bdd8)

After our bucket gets setup, and due to the most recent CDK deployment, we are able to see the image that got uploaded to the “original” folder, and then got processed and save into the “processed” folder with the right format. 

![image](https://github.com/oscarg10/aws-bootcamp-cruddur-2023/assets/56736452/4a58f533-89fa-4200-9e2a-42744ed4035d)

After we were able to see the image being correctly processed to the correct folder, we then created an SNS Topic, Subscription and Event Notification using the code snippets below: 

```jsx
const snsTopic = this.createSnsTopic(topicName)
this.createSnsSubscription(snsTopic,webhookUrl)
const snsPublishPolicy = this.createPolicySnSPublish(snsTopic.topicArn)

lambda.addToRolePolicy(snsPublishPolicy);

createSnsTopic(topicName: string): sns.ITopic{
  const logicalName = "ThumbingTopic";
  const snsTopic = new sns.Topic(this, logicalName, {
    topicName: topicName
  });
  return snsTopic;

createS3NotifyToSns(prefix: string, snsTopic: sns.ITopic, bucket: s3.IBucket): void {
  const destination = new s3n.SnsDestination(snsTopic)
  bucket.addEventNotification(
    s3.EventType.OBJECT_CREATED_PUT,
    destination,
    {prefix: prefix}
  );
}
```

Once that was completed, we shifted to Cloudfront with the idea of creating a distribution with the idea to serve our images. Cloudfront “speeds up distribution of static and dynamic webcontent.” During this process, we added a domain and we also used the same certificate we we used for our main domain. 

Thereafter, we start working on our profile page. Prior to this week, we have a non-functional page so the idea was to add a profile avatar as well as a background image. For this, we had to create a ProfileHeading.js as well as its respective .css. For the background image, we used the following code: 

 

```jsx
import './ProfileHeading.css';
import EditProfileButton from '../components/EditProfileButton';

import ProfileAvatar from 'components/ProfileAvatar'

export default function ProfileHeading(props) {
  const backgroundImage = 'url("https://assets.cruddurog-10.com/banners/Banner.jpg")';
  const styles = {
    backgroundImage: backgroundImage,
    backgroundSize: 'cover',
    backgroundPosition: 'center',
  };
  return (
  <div className='activity_feed_heading profile_heading'>
    <div className='title'>{props.profile.display_name}</div>
    <div className="cruds_count">{props.profile.cruds_count} Cruds</div>
    <div className="banner" style={styles} >
      <ProfileAvatar id={props.profile.cognito_user_uuid} />
    </div>
    <div className="info">
      <div className='id'>
        <div className="display_name">{props.profile.display_name}</div>
        <div className="handle">@{props.profile.handle}</div>
      </div>
      <EditProfileButton setPopped={props.setPopped} />
    </div>
    <div className="bio">{props.profile.bio}</div>
  </div>
  );
}
```

And this was the code use for the ProfileHeading.css: 

```jsx
.profile_heading .avatar {
    position: absolute;
    bottom: -74px;
    left: 16px;  
}
.profile_heading .avatar img {
    width: 148px;
    height: 148px;
    border-radius: 999px;
    border: solid 8px var(--fg);
}

.profile_heading .banner {
    position: relative;
    height: 200px;
}
```

In addition to working on the images, we also setup the bio section to add text to our profile. For this implementation, we had to make sure that we added bio to the show.sql data: 

```jsx
SELECT
  (SELECT COALESCE(row_to_json(object_row),'{}'::json) FROM (
    SELECT
      users.uuid,
      users.cognito_user_id as cognito_user_uuid,
      users.handle,
      users.display_name,
      users.bio,
      (
```

![image](https://github.com/oscarg10/aws-bootcamp-cruddur-2023/assets/56736452/e397ee3c-bc2a-4302-8790-64f655eced41)

Then, we move on to working with API gateway so we can upload images to our S3 bucket. During this process, we generate the code for the lambda that will get triggered by clients. The idea is to generate a pre-signed url that will get used to upload the image. For this implementation, we created the following function using Ruby: 

```jsx
require 'aws-sdk-s3'
require 'json'
require 'jwt'

def handler(event:, context:)
  puts event
  # return cors headers for preflight check
  if event['routeKey'] == "OPTIONS /{proxy+}"
    puts({step: 'preflight', message: 'preflight CORS check'}.to_json)
    { 
      headers: {
        "Access-Control-Allow-Headers": "*, Authorization",
        "Access-Control-Allow-Origin": "localhost_url",
        "Access-Control-Allow-Methods": "OPTIONS,GET,POST"
      },
      statusCode: 200
    }
  else
    token = event['headers']['authorization'].split(' ')[1]
    puts({step: 'presignedurl', access_token: token}.to_json)

    body_hash = JSON.parse(event["body"])
    extension = body_hash["extension"]

    decoded_token = JWT.decode token, nil, false
    cognito_user_uuid = decoded_token[0]['sub']

    s3 = Aws::S3::Resource.new
    bucket_name = ENV["UPLOADS_BUCKET_NAME"]
    object_key = "#{cognito_user_uuid}.#{extension}"

    puts({object_key: object_key}.to_json)

    obj = s3.bucket(bucket_name).object(object_key)
    url = obj.presigned_url(:put, expires_in: 60 * 5)
    url # this is the data that will be returned
    body = {url: url}.to_json
    { 
      headers: {
        "Access-Control-Allow-Headers": "*, Authorization",
        "Access-Control-Allow-Origin": "localhost_url",
        "Access-Control-Allow-Methods": "OPTIONS,GET,POST"
      },
      statusCode: 200, 
      body: body 
    }
  end # if 
end # def handler
```

We execute this function locally, and it generates a presigned url that we tested through Tunder Client. Tunder is a lightweight Rest API Client extension that we can use through gitpod. 

![image](https://github.com/oscarg10/aws-bootcamp-cruddur-2023/assets/56736452/d0d42936-b00d-4d56-8558-26c737d6927c)


Then, we move onto creating an authorization Lambda using the following code: 

```jsx
"use strict";
const { CognitoJwtVerifier } = require("aws-jwt-verify");
//const { assertStringEquals } = require("aws-jwt-verify/assert");

const jwtVerifier = CognitoJwtVerifier.create({
  userPoolId: process.env.USER_POOL_ID,
  tokenUse: "access",
  clientId: process.env.CLIENT_ID//,
  //customJwtCheck: ({ payload }) => {
  //  assertStringEquals("e-mail", payload["email"], process.env.USER_EMAIL);
  //},
});

exports.handler = async (event) => {
  console.log("request:", JSON.stringify(event, undefined, 2));

  const jwt = event.headers.authorization;
  try {
    const payload = await jwtVerifier.verify(jwt);
    console.log("Access allowed. JWT payload:", payload);
  } catch (err) {
    console.error("Access forbidden:", err);
    return {
      isAuthorized: false,
    };
  }
  return {
    isAuthorized: true,
  };
};
```

In addition to the snipped above, we also installed aws-jwt-verify which then generate a package-lock.json, package.json and a node_modules folder with dependencies. When download these files as a zip and then upload it to the Lambda directly. 

Once these two Lambdas are created, we went back to API Gateway for the integration. In here, we integrated the CruddurAvatarUpload as well as the CruddurApiAuthorizer Lambdas to API gateway. 

 
![image](https://github.com/oscarg10/aws-bootcamp-cruddur-2023/assets/56736452/e75c59cf-33b0-4d5b-a7eb-6ee7c0bd14a9)

![image](https://github.com/oscarg10/aws-bootcamp-cruddur-2023/assets/56736452/a3cb5843-75b3-4e98-a9b2-9e53ecd45065)


Once these two are running smoothly, we should be able to see a profile like the one below. Personally, I’m still dealing with a bug that I’m hoping to revisit as much as possible to get it fixed. I’m having issues with the Lambda that uploads the images to our S3 bucket. I’ll explain my issue below, but for now this is the end of week 8. 

![image](https://github.com/oscarg10/aws-bootcamp-cruddur-2023/assets/56736452/4352bff5-6b4c-4861-b379-47fffd298e23)


### Troubleshooting

This week was tough as far as dealing with bugs and such. I ran into a couple that I was able to fix by asking other folks. However, I’ve been dealing with this one bug for almost two weeks without any success. 

The problem is that when I press the edit profile to add a new picture, the image never gets uploaded to the S3 bucket. You may be wondering how you can see an avatar on my profile. Well.. I had to rename my image to my cognito user id. By doing so, I was able to display it. Now, that is not a fix by any means. So far, I tried updating the CORS policy within the Lambda, checking if it was successfully implemented on API Gateway. At this point, I’m moving forward and waiting for the opportunity to discuss it with Andrew during office hours.
