## SwiftEngine Notifications Example  

Here in this repo, you' ll find code to implement for either your client and your swiftengine scripts.


## Overview 

This example will demonstrate how a remote notification gets sent from SwiftEngine.io's API to your iOS application. 

### Basic Setup 

**Note:** Assuming that you've created a p12 certificate and have a device token, you'll do the following to send a push notification to that device.

* Generate pem certificate from p12 certificate using the following command: 
```
  openssl pkcs12 -in <nameOfCertificate>.p12 -out <name>.pem -nodes -clcerts
  ```
* From SwiftEngine's project, create a script file of extension **ssp**

```
<% //<-- must open the tag
import Foundation

/*
  The route below will get invoked every time a GET request get made 
  to this script endoint.  
*/
Request.addHandler(forMethod: "GET") { 

let certificatePath: String = //<- your path 
let deviceToken: String = //<- your deviceToken 

let s = SEApns2() //<-- by default we are using sandbox/dev mode

s.setP12Cert(filePath: certificatePath)

let payload = SEApns2.Payload(alert: "Production from SwiftEngine")
s.setNotificationPayload(payload, toDeviceToken: deviceToken)

s.send { result in //<--- result is of type Result<Response>
    switch result { 
      case .success(let value):  Response("\(value)")
      case .failure(let err):  Response("\(err)")
   }
 }
}
%> //<-- must close the tag
```
   
### More 
In this repo, The **client** and **server** folders contain code to implement both your iOS app and SwiftEngine's script. If you are pretty new the service checkout our [docs](https://kb.swiftengine.net/) (for intro tutorial and articles) 


## Issues 

If you're having or finding any issues, don't hesistate to **open an Issue**, or send us an email at <support@swiftengine.io>

## Further Information 
For more info on the SwiftEngine project, please visit [swiftengine.io](https://www.swiftengine.io/)