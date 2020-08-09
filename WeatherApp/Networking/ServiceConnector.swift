//
//  ServiceConnector.swift
//  WeatherApp
//
//  Created by Ahmed Abdallah on 6.08.2020.
//  Copyright © 2020 MobAhm. All rights reserved.
//

import Moya
import SwiftyJSON

enum WeatherAppService {
  case getCityWeather(params: [String: Any]?)
  case getCities
  case getCitiesGroup(params: [String: Any]?)
}

class ServiceConnector {
  static let shared = ServiceConnector()
  var headers = Dictionary<String, String>()
  private init() {}
  let endpointClosure = { (target: WeatherAppService) -> Endpoint in
    let defaultEndpoint = MoyaProvider.defaultEndpointMapping(for: target)
    ServiceConnector.shared.headers["Authorization"] = "Bearer \("")"
    ServiceConnector.shared.headers["Content-type"] = "application/json"
    return defaultEndpoint.adding(newHTTPHeaderFields: ServiceConnector.shared.headers)
  }
  func headers(_ headers: Dictionary<String, String>) -> ServiceConnector {
    for (key, value) in headers {
      ServiceConnector.shared.headers[key] = value
    }
    return .shared
  }
  func connect(_ target: WeatherAppService) {
    self.connect(target, success: nil)
  }
  func connect(_ target: WeatherAppService, success: ((_ target: WeatherAppService, _ response: JSON, _ statusCode: Int) -> ())?) {
    self.connect(target, success: success, error: nil)
  }
  func connect(_ target: WeatherAppService, success: ((_ target: WeatherAppService,
    _ response: JSON, _ statusCode: Int) -> ())?,
               error: ((_ target: WeatherAppService, _ error: MoyaError) -> ())?) {
    let provider = MoyaProvider<WeatherAppService>(endpointClosure: endpointClosure, plugins: [NetworkLoggerPlugin()])
    //print(target.header ?? "nil")
    print(target.baseURL)
    print(target.path)
    print(target.headers as Any)
    print(target.task.self)
    provider.request(target) { result in
      switch result {
      case let .success(moyaResponse):
        let statusCode = moyaResponse.statusCode // Int - 200, 401, 500, etc
        if statusCode == 403 {
        }
        var dataString = String(data: moyaResponse.data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        dataString?.stringByRemovingRegexMatches(pattern: "\\s{2,}")
        if let dataString = dataString {
          print("Status Code: ", statusCode)
          print("Response: ", dataString)
          // json save end //
          if let success = success {
            success(target, JSON(parseJSON: dataString), statusCode)
          }
        }
      case let .failure(err):
        // json save end //
        if let error = error {
          error(target, err)
        } else {
        }
      }
    }
  }
}

// MARK: - TargetType Protocol Implementation
extension WeatherAppService: TargetType {
  var headers: [String: String]? {
    return [:]
  }
  static let prtc = "https"
  static let base = "api.openweathermap.org/data/2.5"
  var baseURL: URL {
    switch self {
    case .getCities:
      return URL(string: "\(WeatherAppService.prtc)://weathercase-99549.firebaseio.com")!
    default:
      return URL(string: "\(WeatherAppService.prtc)://\(WeatherAppService.base)")!
    }
  }
  var path: String {
    switch self {
    case .getCityWeather:
      return "/weather"
    case .getCities:
      return "/.json"
    case .getCitiesGroup:
      return "/group"
    }
  }
  var method: Moya.Method {
    //    switch self {
    //    case .getCityWeather:
    //      return .post
    //    default:
    return .get
    //}
  }
  public var sampleData: Data {
    return Data()
  }
  var task: Task {
    switch self {
    case .getCityWeather(let params):
      let parameters = get(parameters: params)
      return .requestParameters(parameters:parameters, encoding: URLEncoding.default)
    case .getCitiesGroup(let params):
      let parameters = get(parameters: params)
      return .requestParameters(parameters:parameters, encoding: URLEncoding.default)
    default:
      return .requestPlain
    }
  }
}

// MARK: - Helpers
private extension String {
  var urlEscaped: String {
    return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
  }
  var utf8Encoded: Data {
    return self.data(using: .utf8)!
  }
  mutating func stringByRemovingRegexMatches(pattern: String, replaceWith: String = "") {
    do {
      let regex = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
      let range = NSMakeRange(0, self.count)
      self = regex.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: replaceWith)
    } catch {
      return
    }
  }
}

extension WeatherAppService {
  func get(parameters: [String: Any]?) -> [String: Any] {
    var paramArray = [String: Any]()
    if let params = parameters {
      for (key, value) in params {
        paramArray.updateValue(value, forKey: key)
      }
    }
    return paramArray
  }
}
