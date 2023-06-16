# Week 8 — Serverless Image Processing

# Serverless Image Process

Add the cdk into gitpod.yml so it starts everytime we spin up a new instance. Once add it to the .yaml, we need to npm install aws-cdk. To test it, we need to run 

```jsx
cdk deploy
```

 

We have to add the env vars into a .env file. To keep in mind - we want to name these vars “{name}.cruddurog-10.com.” The reason being that this is the format required by Cloudformation.

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/2a1b9a84-b22d-47e5-b9e2-a81e63ebfd9a/Untitled.png)

 Then we need to create a ‘process-images’ folder to keep our images. Once that is done, we proceeded to establish our env vars. 

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/debe6442-964a-44f4-aeb8-c427fd3a551e/Untitled.png)

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

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/c7a192df-9745-47c1-a51c-b5b23988ff86/Untitled.png)

After adding this code, we need to cdk synth to confirm everything is okay before running cdk deploy 

- For the bucket arn issue, we decided to import the bucket to the thumbing file.

Create folders within our S3 bucket and add a .jpeg image. Preferably we will do it through the CLI by creating an upload bsah script.  

Also, as a clean up process, we tweaked the fargate command in the gitpod.yml to get rid of the sessions manager plugin file. 

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/55ac0c5c-46af-410c-aa34-cb3690801b3c/Untitled.png)

### Implementation

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/b517ce70-cfd5-4b70-9a74-bb20f80389c6/Untitled.png)

After our bucket gets setup, and due to the most recent CDK deployment, we are able to see the image that got uploaded to the “original” folder, and then got processed and save into the “processed” folder with the right format. 

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/a62b0ec4-522e-4a9c-9735-5a54c1a939a8/Untitled.png)

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

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/39dbe5a6-852f-4a1b-a007-4fe897481e35/Untitled.png)

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

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/a98d73c2-600f-4f43-a949-3db6f7dc9301/Untitled.png)

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

 

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/452a91cb-876c-40b3-8f53-43494dad8dbb/Untitled.png)

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/e77c0884-209f-4207-af85-8c0c106edfd9/Untitled.png)

Once these two are running smoothly, we should be able to see a profile like the one below. Personally, I’m still dealing with a bug that I’m hoping to revisit as much as possible to get it fixed. I’m having issues with the Lambda that uploads the images to our S3 bucket. I’ll explain my issue below, but for now this is the end of week 8. 

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/d5f6df8c-b26a-440f-99ee-98617e699914/Untitled.png)

### Troubleshooting

This week was tough as far as dealing with bugs and such. I ran into a couple that I was able to fix by asking other folks. However, I’ve been dealing with this one bug for almost two weeks without any success. 

The problem is that when I press the edit profile to add a new picture, the image never gets uploaded to the S3 bucket. You may be wondering how you can see an avatar on my profile. Well.. I had to rename my image to my cognito user id. By doing so, I was able to display it. Now, that is not a fix by any means. So far, I tried updating the CORS policy within the Lambda, checking if it was successfully implemented on API Gateway. At this point, I’m moving forward and waiting for the opportunity to discuss it with Andrew during office hours.
