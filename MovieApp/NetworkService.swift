import Foundation

enum RequestError: Error {
    case clientError
    case serverError
    case noDataError
    case decodingError
}

class NetworkService {
    func executeUrlRequest<T: Decodable>(_ request: URLRequest, completionHandler:@escaping (Result<[T], RequestError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: request) { data, response,
            err in
            guard err == nil else {
                completionHandler(.failure(.clientError))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,(200...299).contains(httpResponse.statusCode) else {
                completionHandler(.failure(.serverError))
                return
            }
            guard let data = data else {
                completionHandler(.failure(.noDataError))
                return
            }
            guard let value = try? JSONDecoder().decode([T].self, from: data) else {
                completionHandler(.failure(.decodingError))
                return
            }
            completionHandler(.success(value))
        }
        dataTask.resume()
    }
    
    func makeUrlRequest(categories: String, criteria: String, completionHandler: @escaping (Result<[MovieResponse], Error>) -> Void){
        guard let url = URL(string: "https://five-ios-api.herokuapp.com/api/v1/movie/\(categories)?criteria=\(criteria)") else {
            return completionHandler(.failure(RequestError.serverError))
        }
        var request = URLRequest(url: url)
        request.setValue("Bearer Zpu7bOQYLNiCkT32V3c9BPoxDMfxisPAfevLW6ps", forHTTPHeaderField: "Authorization")
            executeUrlRequest(request) { (result: Result<[MovieResponse], RequestError>) in
            switch result {
            case .failure(let error):
                return completionHandler(.failure(RequestError.serverError))
            case .success(let value):
                return completionHandler(.success(value))
            }
        }
    }
}
