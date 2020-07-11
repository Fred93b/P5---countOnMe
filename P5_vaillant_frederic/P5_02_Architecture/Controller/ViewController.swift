//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    // MARK: - Properties
    lazy var calculator = Calculator(textViewModel: textView.text)
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    // MARK: - Actions
    /// Appuyez sur les boutons numériques
    @IBAction func tappedNumberButton(_ sender: UIButton) {
            guard let numberText = sender.title(for: .normal) else {
                return
            }
            calculator.addNumberForCalculate(number: numberText)
            textView.text = calculator.textViewModel
        }
    /// Appuyez sur les boutons des opérateurs
    @IBAction func tappedOperatorButton(_ sender: UIButton) {
        guard let operatorText = sender.title(for: .normal) else {
            return
        }

        guard calculator.addOpertorForCalculate(operators: operatorText) else {
            return showAlert(with: "Vous avez déjà ajouté un opérateur.")
        }

        textView.text = calculator.textViewModel
    }
    /// Appuyez sur le bouton égal
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        let resultStatus = calculator.makeCalculation()
        guard resultStatus.validity else {
            return showAlert(with: resultStatus.message)
        }
        textView.text = calculator.textViewModel

        }
    /// Appuyez sur le bouton annuler
    @IBAction func tappedResetButton(_ sender: UIButton) {
        calculator.reset()
        textView.text = calculator.textViewModel
    }
    // MARK: - Methods
    /// Message d'alerte
        func showAlert(with message: String) {
        let alertVC = UIAlertController(title: "Erreur :",
                                                message: message,
                                                preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
            }
    }
