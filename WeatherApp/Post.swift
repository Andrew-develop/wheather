//
//  Post.swift
//  WeatherApp
//
//  Created by Sergio Ramos on 25/07/2020.
//  Copyright © 2020 Sergio Ramos. All rights reserved.
//

import Foundation

struct Post {

    var temperature: Int
    var name: String
    var wind_speed: Int
    var feelslike: Int

    init?(json: [String: Any]) {

        guard
            let temperature = json["temperature"] as? Int,
            let name = json["name"] as? String,
            let wind_speed = json["wind_speed"] as? Int,
            let feelslike = json["feelslike"] as? Int
        else {
            return nil
        }

        self.temperature = temperature
        self.name = name
        self.wind_speed = wind_speed
        self.feelslike = feelslike
    }

    static func getArray(from jsonArray: Any) -> [Post]? {

        guard let jsonArray = jsonArray as? Array<[String: Any]> else { return nil }
        var posts: [Post] = []

        for jsonObject in jsonArray {
            if let post = Post(json: jsonObject) {
                posts.append(post)
            }
        }
        return posts
    }
}
