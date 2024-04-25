package com.mobile.pratica.AA_05.`fun`

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import android.widget.EditText
import androidx.fragment.app.Fragment
import androidx.navigation.fragment.findNavController
import com.mobile.pratica.AA_05.R


class InputFragment : Fragment() {
    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        val view = inflater.inflate(R.layout.fragment_input, container, false)

        val editText = view.findViewById<EditText>(R.id.editText)
        val submitButton = view.findViewById<Button>(R.id.submitButton)

        submitButton.setOnClickListener {
            val inputText = editText.text.toString()
            val action = InputFragmentDirections.actionInputFragmentToOutputFragment(inputText)
            findNavController().navigate(action)
        }

        return view
    }
}