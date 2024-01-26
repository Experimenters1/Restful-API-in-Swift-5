# Restful-API-in-Swift-5

[Restful API in Swift 5](https://chat.openai.com/c/c4746939-b698-482d-ab1e-16317c450559) <br><br>

[lấy data để render ra màn hình](https://chat.openai.com/c/b69e2793-f0b5-4651-9282-99dce909d4a6) <br><br>

[ví dụ đặt hàm fetchData ở viewDidLoad hay đâu ?](https://chat.openai.com/c/e601fc1f-9e06-4f8f-9947-c66b6d6b73ac) <br><br>

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
