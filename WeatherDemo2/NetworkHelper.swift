//
//  NetworkHelper.swift
//  WeatherDemo2
//
//  Created by 小波 on 16/4/25.
//  Copyright © 2016年 xiaobo. All rights reserved.
//

import Just

enum NetworkHelper {
    
    case WeeklyWeather(cityid: String)
    
    //http://api.k780.com:88/?app=weather.future&weaid=1&&appkey=10003&sign=b59bc3ef6191eb9f747dd4e83c99f2a4&format=json
    
    
    private static var params = [
        "app":"weather.future",
        "appkey":"12215",
        "sign":"24c28ec9c8629ce27cfbec8af12cf353",
        "format":"json"
    ]
    
    private static let baseUrl = "http://api.k780.com:88"
    
    func getWeather(completion: ([Result]?, String?) -> Void) {
        
        var error: String?
        var results: [Result]?
        
        switch self {
        case .WeeklyWeather(cityid: let weaid):
            
            NetworkHelper.params["weaid"] = weaid
            
            Just.get(NetworkHelper.baseUrl, params: NetworkHelper.params,asyncCompletionHandler: { (r) in
                if r.ok {
                    //确保返回结果是一个json,并可转换为一个字典
                    guard let jsonDict = r.json as? NSDictionary else {
                        error = "不是一个json字符串"
                        return
                    }
                    
                    //确保字典中的success字段的值是1
                    guard let success = jsonDict["success"] where success as? String == "1" else {
                        error = "返回数据格式不对，或者授权错误"
                        return
                    }
                    
                    let weather = Weather(fromDictionary: jsonDict)
                    results = weather.result
                    
                } else {
                    error = "服务器出错"
                }
                
                completion(results, error)
                
            })
        
        }
    }
    
}
