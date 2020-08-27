//
//  Calculator.swift
//  CountOnMe
//
//  Created by vaillant on 18/06/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

import Foundation

class Calculator {
    // MARK: - Properties
    var textViewModel = String()
    /// Récupère et gère les nombres et les opérateurs de textView.text vers un tableau ou chaque élément est séparé
    var elements: [String] {
    return textViewModel.split(separator: " ").map { "\($0)" }
}
    var canAddOperator: Bool {
        checkValidity()
    }
    var expressionHaveResult: Bool {
        return textViewModel.contains("=")
    }
    var expressionIsCorrect: Bool {
        checkValidity()
    }
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    // MARK: - Init
    init(textViewModel: String) {
        if textViewModel == "0" {
            self.textViewModel = ""
        } else {
            self.textViewModel = textViewModel
        }
    }
    // MARK: - Methods
    /// vérifie que le dernier élément passé n'est pas un opérateur
    func checkValidity() -> Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "*" && elements.last != "/"
    }
    ///  ajoute un nombre pour calculer
    func addNumberForCalculate(number: String) {
        if expressionHaveResult {
            textViewModel = ""
        }
        if textViewModel == "0" {
            textViewModel = number
        } else {
            textViewModel.append(number)
        }
    }
    /// ajoute un operateur pour calculer
    func addOpertorForCalculate(operators: String) -> Bool {
        guard canAddOperator else {
            return false
        }

        if let lastElement = elements.last, expressionHaveResult {
            textViewModel = lastElement
        }

        textViewModel.append(" \(operators) ")
        return true
    }

    ///expression du calcul
    // swiftlint:disable:next cyclomatic_complexity
    func makeCalculation() -> (validity: Bool, message: String) {
        guard expressionIsCorrect else {
            return (false, "Entrez une expression correcte !")
        }
        guard expressionHaveEnoughElement else {
            textViewModel = "0"
            return (false, "Démarrez un nouveau calcul !")
        }
        guard !expressionHaveResult else {
             if let lastElement = elements.last {
                textViewModel = lastElement
                return (true, "\(lastElement)")
        }
            return (false, "0")
        }
    /// Créer une copie locale des opérations
        var calculsToReduce = elements
    /// Itérer sur les opérations alors qu'un opérande est toujours là
    while calculsToReduce.count > 1 {
        var operandIndex = Int()
    /// condition pour donner la priorité à la multiplication et la division
        if let priorityIndex = calculsToReduce.firstIndex(where: {$0 == "*" || $0 == "/"}) {
            operandIndex = priorityIndex
        } else {
            operandIndex = 1
        }
        let operand = calculsToReduce[operandIndex]
        guard let left = Float(calculsToReduce[operandIndex - 1]), let right = Float(calculsToReduce[operandIndex + 1])
        else {
            textViewModel = "0"
            return (false, "expression non valide !")
        }
        var result: Float
        switch operand {
        case "+": result = left + right
        case "-": result = left - right
        case "*": result = left * right
            /// vérifier la division par zéro et réinitialiser le texte
        case "/": if right == 0 {
            textViewModel = "0"
            return (false, "expression non valide !")
        } else {
            result = left / right
            }
        default: fatalError("Opérateur inconnu !")
    }
    /// gérer les calculs prioritaires et donner le résultat
        calculsToReduce.remove(at: operandIndex + 1)
        calculsToReduce.remove(at: operandIndex)
        calculsToReduce.remove(at: operandIndex - 1)
        calculsToReduce.insert("\(result)", at: operandIndex - 1)
}
        if let operationsToReduceFirst = calculsToReduce.first {
    textViewModel.append(" = \(operationsToReduceFirst)")
}
    return (true, "")
}
    /// annuler le calcul
    func reset() {
        textViewModel = "0"
    }
}
