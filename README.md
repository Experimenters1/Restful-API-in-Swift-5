# Restful-API-in-Swift-5

[Restful API in Swift 5](https://chat.openai.com/c/c4746939-b698-482d-ab1e-16317c450559) <br><br>


# URLSession <br><br>
```swift
import Foundation

let url = URL(string: "https://api.example.com/data")!

let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
    if let error = error {
        print("Error: \(error)")
    } else if let data = data {
        // Xử lý dữ liệu nhận được từ server
        print("Received data: \(data)")
    }
}

task.resume()
```
# Alamofire <br><br>
```swift
import Alamofire

AF.request("https://api.example.com/data").responseJSON { response in
    switch response.result {
    case .success(let value):
        // Xử lý dữ liệu nhận được từ server
        print("Received data: \(value)")
    case .failure(let error):
        print("Error: \(error)")
    }
}
```
