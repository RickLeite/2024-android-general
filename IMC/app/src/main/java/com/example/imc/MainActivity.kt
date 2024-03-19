package com.example.imc

import android.os.Bundle
import android.view.View
import android.widget.Button
import android.widget.EditText
import android.widget.TextView
import android.widget.Toast
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat



class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContentView(R.layout.activity_main)
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }

        val buttonCalculate = findViewById<Button>(R.id.btnCalculateIMC)
        buttonCalculate.setOnClickListener  {
            val nomeUser = findViewById<EditText>(R.id.editTextName).text.toString()
            val idadeUser = findViewById<EditText>(R.id.editTextAge).text.toString()
            val pesoUser = findViewById<EditText>(R.id.editTextWeight).text.toString().toDouble()
            val alturaUser = findViewById<EditText>(R.id.editTextHeight).text.toString().toDouble()

            val user = User(nomeUser, idadeUser.toInt(), pesoUser, alturaUser)


            val textViewHiddenResultClassificacao = findViewById<TextView>(R.id.textViewHiddenResultClassificacao)
            textViewHiddenResultClassificacao.text = user.calcularIMC().toString()
            textViewHiddenResultClassificacao.visibility = View.VISIBLE

            val textViewHiddenResultFaixa = findViewById<TextView>(R.id.textViewHiddenResultFaixa)
            textViewHiddenResultFaixa.text = user.faixasIMC()
            textViewHiddenResultFaixa.visibility = View.VISIBLE



        }


    }


}