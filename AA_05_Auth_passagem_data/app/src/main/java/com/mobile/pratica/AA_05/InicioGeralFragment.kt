package com.mobile.pratica.AA_05


import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import androidx.navigation.fragment.findNavController

class InicioGeralFragment : Fragment() {

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        val view = inflater.inflate(R.layout.fragment_inicio_geral, container, false)

        val botaoInput = view.findViewById<Button>(R.id.botao_input)
        val botaoDisplay = view.findViewById<Button>(R.id.botao_display)

        view.findViewById<Button>(R.id.botao_input).setOnClickListener {
            // Navegar para o fragmento botao_input
            findNavController().navigate(R.id.action_InicioGeralFragment_to_inputFragment)
        }

        view.findViewById<Button>(R.id.botao_display).setOnClickListener {
            // Navegar para o fragmento botao_display
            findNavController().navigate(R.id.action_InicioGeralFragment_to_displayFragment)
        }

        return view
    }
}