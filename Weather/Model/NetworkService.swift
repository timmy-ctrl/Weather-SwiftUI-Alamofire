import UIKit
import Alamofire
import Combine

final class NetworkService: ObservableObject {
    @Published var data = "Загрузка..."
    @Published var errorMessage: String? = nil
    
    func getData() {
        AF.request("https://httpbin.org/get").response { response in
            switch response.result {
            case .success(let data):
                if let data = data, let jsonString = String(data: data, encoding: .utf8) {
                    DispatchQueue.main.async {
                        print("Полученные данные:\n\(jsonString)")
                        self.data = jsonString
                    }
                } else {
                    DispatchQueue.main.async {
                        self.data = "Ошибка преобразования данных"
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                    self.data = "Не удалось загрузить данные"
                }
            }
        }
    }
}
