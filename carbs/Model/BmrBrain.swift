//
//  BmrBrain.swift
//  carbs
//
//  Created by Aleksandr Khalupa on 24.02.2021.
//

import Foundation


struct BmrBrain {
    
    var objectBMR: BMR?
    
    
    
   mutating func getBMR(weight:Float, height:Float, age:Float, indexGender:Float, index: Float) {
       let bmrResult = ((weight * 10) + (height * 6.25 ) - (age * 5) + indexGender) * index
    

    
    let proteinResult = bmrResult * 0.3 / 4
    let fatsResult = bmrResult *  0.3 / 9
    let carbsResult = bmrResult * 0.4 / 4
    
    objectBMR = BMR(bmr: bmrResult, protein: proteinResult, fats: fatsResult, carbs: carbsResult)

    }
    
    func BJUifChangeSegment(objBmr:String) -> [String]{
        let bmrResult = Float(objBmr) ?? 0
    
        let proteinResult = bmrResult * 0.3 / 4
        let fatsResult = bmrResult *  0.3 / 9
        let carbsResult = bmrResult * 0.4 / 4
        let BJUArray = [String(format: "%.0f", proteinResult), String(format: "%.0f", fatsResult), String(format: "%.0f", carbsResult)]
      return BJUArray
    }
    
    
    func getBMRifChangeSegment(numberOfSegment:Int, resultBMR:String) -> String{
       let objBmr = Float(resultBMR) ?? 0
        var segment:Float = 0
        print("1 \(objBmr)")
        
        if numberOfSegment == 0{
           segment = objBmr - (objBmr * 0.2)
            print("2 \(objBmr)")
        } else if numberOfSegment == 2{
           segment = objBmr + (objBmr * 0.2)
            print("3 \(objBmr)")
        }
            
        return String(format: "%.0f", segment)
    }
    
    
    func sendBMR()-> String {
        return String(format: "%.0f", objectBMR?.bmr ?? 1.0)
    }
    
    func sendCarbs()->String{
        return String(format: "%.0f", objectBMR?.carbs ?? 1.0)
    }
    
    func sendFats()->String{
        return String(format: "%.0f", objectBMR?.fats ?? 1.0)
    }
    
    func sendProtein()->String{
        return String(format: "%.0f", objectBMR?.protein ?? 1.0)
    }

}







//Норма 1333
//У 40%
//Б 30%
//Ж 30%
//У 1333/100*40/4=133,3 гр
//Б 1333/100*30/4=99,975 гр
//Ж 1333/100*30/9 (стандартный показатель калорий на 1 гр жира)= 44,43 гр
