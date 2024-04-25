package com.mobile.pratica.AA_05.`fun`

import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.fragment.app.Fragment
import com.mobile.pratica.AA_05.R
import java.text.DecimalFormat
import java.text.NumberFormat
import java.util.*

class DisplayFragment : Fragment() {

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        val view = inflater.inflate(R.layout.fragment_display, container, false)

        val displayTextView = view.findViewById<TextView>(R.id.displayTextView)

        // Recuperar o texto enviado do InputFragment
        val textReceived = arguments?.getString("inputText")

        // Exibir o texto no TextView
        displayTextView.text = textReceived

        return view
    }
}