package com.example.imc

class User(private var nome: String?, private var idade: Int?, private var peso: Double?, private var altura: Double?){



    fun calcularIMC(): Double {
        val pesoValue = peso ?: 0.0
        val alturaValue = altura ?: 1.0
        val imc: Double = if (alturaValue != 0.0) pesoValue / (alturaValue * alturaValue) else 0.0
        return "%.2f".format(imc).toDouble()
    }

    fun faixasIMC(): String {
        val imc = calcularIMC()
        if (imc < 18.5) {
            return "Abaixo do peso"
        } else if (imc < 24.9) {
            return "Peso normal"
        } else if (imc < 29.9) {
            return "Sobrepeso"
        } else if (imc < 34.9) {
            return "Obesidade grau 1"
        } else if (imc < 39.9) {
            return "Obesidade grau 2"
        } else {
            return "Obesidade grau 3"
        }
    }

}