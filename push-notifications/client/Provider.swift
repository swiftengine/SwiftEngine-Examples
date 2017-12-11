import Foundation

/*
  Provider will be reponsible to send our payload to our SwitfEngine.io API

Important:
   we've turn on App Transport Security from our plist, to allow http access for any subdomain of swiftengine.io
*/

class Provider {
	// endpoint where your script is running
	static let postEndpoint = "http://testing.site.swiftengine.net/push-notifications.ssp"
	
	func send(payload:[String:Any], callback:@escaping (Error?)-> Void) {
		if let url = Provider.postEndpoint.toUrl() {
			post(toUrl: url, payload: payload) {
				 callback($0)
			}
		}
	}
	
}

extension Provider {
	
	// basic URLSession
	// you can use any networking library such as Alamofire
	private func post(toUrl url:URL, payload:[String:Any], callback:@escaping (Error?)-> Void) {
		
		let mRequest = NSMutableURLRequest(url: url)
		mRequest.httpMethod = "POST"
		mRequest.allHTTPHeaderFields = [
			"Content-Type":"application/json",
			"Accept": "application/json"
		]
		do {
			// transform our dictionary to Data
			mRequest.httpBody = try JSONSerialization.data(withJSONObject: payload, options: .prettyPrinted)
		}
		catch { callback(error) }
		
		let request = mRequest as URLRequest
		
		URLSession.shared.dataTask(with: request) { (_, response, err) in
			if let err = err {
				// failure 
				callback(err)
			}
			if let _response = response as? HTTPURLResponse {
				if _response.statusCode == 200 || _response.statusCode == 201 {
					// success posting
					callback(nil)
				}
			 }
		 }.resume()
	}
}

extension String {
	func toUrl() -> URL? {
		return URL(string:self)
	}
}
