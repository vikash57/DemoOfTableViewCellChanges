//
//  JsonConfiguration.swift
//  NewAudioPlayerProject
//
//  Created by NexG on 22/06/23.
//

import Foundation


func fetchData(completionHandler: (ModelData) -> Void){
    guard let fileLocation = Bundle.main.url(forResource: "JsonData", withExtension: "json") else {
        print("do not search file location")
        return
    }
    
    do{
        let jsonData = try Data(contentsOf: fileLocation)
        do{
            let decoder = try JSONDecoder().decode(ModelData.self, from: jsonData)
            completionHandler(decoder as! ModelData)
        }catch{
            print("JSON Data Error \(error)")
        }
    }catch{
        print("error")
    }
}

func fetchData1(completionHandler: (DescriptionData) -> Void){
    guard let fileLocation = Bundle.main.url(forResource: "DescribtionData", withExtension: "json") else {
        print("do not search file location")
        return
    }
    
    do{
        let jsonData = try Data(contentsOf: fileLocation)
        do{
            let decoder = try JSONDecoder().decode(DescriptionData.self, from: jsonData)
            completionHandler(decoder as! DescriptionData)
        }catch{
            print("JSON Data Error \(error)")
        }
    }catch{
        print("error")
    }
}
