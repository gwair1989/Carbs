//
//  CalculateViewController.swift
//  carbs
//
//  Created by Aleksandr Khalupa on 24.02.2021.
//

import UIKit

class RecalculateVC: UIViewController {
    
    @IBOutlet weak var maintainingLabel: UILabel!
    @IBOutlet weak var backgroundGender: UIImageView!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var targetSegmented: UISegmentedControl!
    @IBOutlet weak var targetLabel: UILabel!
    
    var resultBMR = ""
    var segment:Float = 0
    var isGender: Bool?
    var carbs = ""
    var proteine = ""
    var fats = ""
    var objBmr = ""
    var bmrBrain = BmrBrain()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        maintainingLabel.layer.cornerRadius = 5
        maintainingLabel.layer.masksToBounds = true
        
        resultLabel.text = "Ваша норма каллорий:\n\(resultBMR) ккал"
        targetLabel.text = "Ремендуемый показатель БЖУ:\n Белки: \(proteine) гр\n Жиры: \(fats) гр\n Углеводы: \(carbs) гр"
        
        if isGender == true {
            backgroundGender.image = UIImage(named: "woman")
            resultLabel.textColor = .black
            targetLabel.textColor = .black
        }
    }

    
    @IBAction func actionTargetSegmnted(_ sender: UISegmentedControl) {
        
       let numberOfSegment = targetSegmented.selectedSegmentIndex
        
        objBmr = bmrBrain.getBMRifChangeSegment(numberOfSegment: numberOfSegment, resultBMR: resultBMR)
        
        let bjuArray = bmrBrain.BJUifChangeSegment(objBmr: objBmr)
        
        if  numberOfSegment == 0{
            resultLabel.text = "Ваша норма каллорий:\n\(objBmr) ккал"
            targetLabel.text = "Ремендуемый показатель БЖУ:\n Белки: \(bjuArray[0]) гр\n Жиры: \(bjuArray[1]) гр\n Углеводы: \(bjuArray[2]) гр"
        }  else if numberOfSegment == 1{
            resultLabel.text = "Ваша норма каллорий:\n\(resultBMR) ккал"
            targetLabel.text = "Ремендуемый показатель БЖУ:\n Белки: \(proteine) гр\n Жиры: \(fats) гр\n Углеводы: \(carbs) гр"
        } else {
            resultLabel.text = "Ваша норма каллорий:\n\(objBmr) ккал"
            targetLabel.text = "Ремендуемый показатель БЖУ:\n Белки: \(bjuArray[0]) гр\n Жиры: \(bjuArray[1]) гр\n Углеводы: \(bjuArray[2]) гр"
        }
    }
    
    
    @IBAction func recalculateButton(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func pressedBuy(_ sender: UIButton) {
        maintainingLabel.isHidden = true
        targetSegmented.isHidden = false
    }
    
}
