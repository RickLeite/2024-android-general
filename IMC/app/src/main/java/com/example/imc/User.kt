package com.example.imc

class User(private var nome: String?, private var idade: Int?, private var peso: Double?, private var altura: Double?){

    init {
        nome = nome.takeIf { !it.isNullOrEmpty() } ?: "Unknown"

        idade = idade?.let {
            try {
                it.toInt()
            } catch (e: NumberFormatException) {
                0
            }
        } ?: 0

        peso = peso?.takeIf { it >= 0.0 } ?: 0.0
        altura = altura?.takeIf { it >= 0.0 } ?: 0.0
    }

    fun calcularIMC(): Double {
        val pesoValue = peso ?: 0.0
        val alturaValue = altura ?: 1.0
        return if (alturaValue != 0.0) {
            pesoValue / (alturaValue * alturaValue)
        } else {
            0.0
        }
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