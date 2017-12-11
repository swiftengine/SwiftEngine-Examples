/*
 By Lamour
 Dec 11, 2017
*/

import UIKit
import UserNotifications


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		 requestUserPermision()
		return true
	}
	
}

extension AppDelegate: UNUserNotificationCenterDelegate {
	// asking for permission
	// and should be called every time your app is fired or launched from the appDelegate's method
	// didFinishLaunchingWithOptions
	private func requestUserPermision() {
		UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound]) { (_, err) in
			if err != nil {
				// there is an error & you should prepare to ask permission again
				 print(err?.localizedDescription)
			} else {
				// we are requesting to register into APNS
				// also you should subscribe to UNUserNotificationCenterDelegate to get
				// all the response from APNS such as deviceToken, or any errors
				UIApplication.shared.registerForRemoteNotifications()
			}
		}
	}
	
	// from this delegate, we get the deviceToken from APNS if we've successfully register to APNS
	func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
		// transfrom deviceToken from Data to String
		let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
		// uid is just metadata that is attached to your payload
		let uid = String(Int(arc4random_uniform(100)))
		let payload = ["token": token, "uid": uid]
		// Our Provider class will send our payload to SwiftEngine.io's script
		Provider().send(payload: payload) { (err) in
			if let err = err {
				print("failed to send payload \(err)")
			}
			print("Payload was successfully sent")
		}
	}
	
	// Error if we failed to register to APNS
	// usually you should not use your Simulator
	func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
		print("\(error.localizedDescription)")
	}
	

	// this delegate will be called (to show/present your notification) in foreground
	// meaning while the user is interacting with your app
	func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
		completionHandler([.sound,.alert,.badge])
	}
	
	
    // this delegate will be called (to show/present your notification) in background mode
	// make sure that Background Modes from Capabilities of the Project is turn on
	// for remote and Background Fetch
	func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
		completionHandler(.newData)
	}
	
	// this delegate is optional, but if you want to add action to your notification i.e
	// adding deeplinking into your notification, if you want the user to go to a specific location
	// into your app.
	func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
		// you've received a notification
		// if you wished to do any decoding
		// you'll find the content of your notification payload here: response.notification.request.content
		completionHandler()
	}
	
	
}


