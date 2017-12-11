## SwiftEngine Notifications Example  

Here in this repo, you' ll find code to implement for either your client and your swiftengine scripts.


## Overview 

This example will demonstrate how a remote notification gets sent from SwiftEngine.io's API to your iOS application. 

#### Content
* Intro to Push Notification [1](), [2](https://kb.swiftengine.net/knowledge-base/push-notifications/), [3](https://kb.swiftengine.net/knowledge-base/push-notifications-setting-up-xcode/)
* Enable Remote Notifications for your App.[1]() [2]() 
* Implementing client's code. 
* Create **pem** certicates from **aps** certificate.
  ```
  openssl pkcs12 -in <nameOfCertificate>.p12 -out <name>.pem -nodes -clcerts
  ```
* Setup SwiftEngine's project [1](), [2](https://kb.swiftengine.net/knowledge-base/push-notification-server-side-example/) 
* Creating an SwiftEngine API endpoint to send our notification payload to our client.

## Issues 

If you are having or finding any issues, don't hesistate to **open an Issue** in this repo, or **open a ticket via our SwiftEngine portal**, or send us an email at <support@swiftengine.io>

## Further Information 
For more info on the SwiftEngine project, please visit [swiftengine.io](https://www.swiftengine.io/)