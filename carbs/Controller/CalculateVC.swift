//
//  ViewController.swift
//  carbs
//
//  Created by Aleksandr Khalupa on 18.01.2021.
//

import UIKit

class CalculateVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var indexSliderOut: UISlider!
    
    @IBOutlet weak var backgroundGender: UIImageView!
    
    @IBOutlet weak var indexLabel: UILabel!
    
    @IBOutlet weak var infoLabel: UILabel!
    
    @IBOutlet weak var heightTextField: UITextField!
    
    @IBOutlet weak var weightTextField: UITextField!
    
    @IBOutlet weak var ageTextField: UITextField!
    
    @IBOutlet var genderButtonColelection: [UIButton]!
    
    
    var indexGender:Float = 0.0
    var bmrBrain = BmrBrain()
    var isGender = false
    
    
    
    //        BMR – базовый уровень метаболизма (basal metabolic rate)
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        heightTextField.delegate = self
        weightTextField.delegate = self
        ageTextField.delegate = self
       setUI()
    }


    
    @IBAction func indexSlider(_ sender: UISlider) {
       let value = String(format: "%.2f", sender.value)
        indexLabel.text = value
        
        if sender.value > 1{
            setUI()
        }
        
    }
    
    
    @IBAction func genderButton(_ sender: UIButton) {
        
       
        if sender.tag == 0 && sender.backgroundColor == .white{
            indexGender = 5
            sender.backgroundColor = .brown
            backgroundGender.image = UIImage(named: "man")
            genderButtonColelection[1].isEnabled = false
            isGender = false
            infoLabel.textColor = .white
            indexLabel.textColor = .white
        } else if sender.tag == 0 && sender.backgroundColor == .brown{
            sender.backgroundColor = .white
            genderButtonColelection[1].isEnabled = true
            
        }
        
        
        if sender.tag == 1 && sender.backgroundColor == .white{
            sender.backgroundColor = .magenta
            backgroundGender.image = UIImage(named: "woman")
            isGender = true
            genderButtonColelection[0].isEnabled = false
            indexGender = -161
            infoLabel.textColor = .black
            indexLabel.textColor = .black
        } else if sender.tag == 1 && sender.backgroundColor == .magenta{
            sender.backgroundColor = .white
            genderButtonColelection[0].isEnabled = true
        }
       
    }
    
    @IBAction func calculateButton(_ sender: UIButton) {
        
        let height = Float(heightTextField.text ?? "0") ?? 0
        let weight = Float(weightTextField.text ?? "0") ?? 0
        let age = Float(ageTextField.text ?? "0") ?? 0
        let index = indexSliderOut.value
         
       bmrBrain.getBMR(weight: weight, height: height, age: age, indexGender: indexGender, index: index)
        enterData()
        
        
        
//        BMR – базовый уровень метаболизма (basal metabolic rate)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toRecalculateVC"{
            let resultVC = segue.destination as! RecalculateVC
            let resultBMR = bmrBrain.sendBMR()
            resultVC.resultBMR = resultBMR
            resultVC.carbs = bmrBrain.sendCarbs()
            resultVC.fats = bmrBrain.sendFats()
            resultVC.proteine = bmrBrain.sendProtein()
            
            
            
            
            print(isGender)
            if isGender {
                resultVC.isGender = isGender
                
            }
            
            
        }
    }
    
    
 
    
    
    
    func setUI(){
        infoLabel.text = "Как определить коэффициент активности:\n1,2 –  минимальная активность \n 1,4 – небольшая активность \n 1,46 – средняя активность \n 1,55 – активность выше среднего \n 1,64 – повышенная активность \n 1,72 – высокая активность \n 1,9 – очень высокая активность"
    }
    
    
    
    
    
    
    func enterData (){
        if ageTextField.text == "" {
            ageTextField.placeholder = "Введите Ваш возраст!"
        } else if weightTextField.text == ""{
            weightTextField.placeholder = "Введите Ваш вес!"
        }else if heightTextField.text == "" {
            heightTextField.placeholder = "Введите Ваш рост!"
        } else if genderButtonColelection[0].backgroundColor == .white && genderButtonColelection[1].backgroundColor == .white{
            infoLabel.text = "Выберете Ваш пол!"
        }else if indexSliderOut.value < 1.19 {
            infoLabel.text = "Выберете коэффициент активности!"
        } else{
                setUI()
            performSegue(withIdentifier: "toRecalculateVC", sender: self)
        }
        
    }
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        heightTextField.endEditing(true)
        weightTextField.endEditing(true)
        ageTextField.endEditing(true)
        return true
    }
    
}

