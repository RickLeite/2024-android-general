package com.example.loginmudaactivity

import android.content.Intent
import android.os.Bundle
import android.widget.Button
import android.widget.EditText
import android.widget.Toast
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import com.google.android.material.textfield.TextInputEditText

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

        val userAdmin = "admin"
        val passwordAdmin = "admin"

        val loginButton = findViewById<Button>(R.id.login_button)

        loginButton.setOnClickListener {
            val usernameEditText = findViewById<EditText>(R.id.username_edittext)
            val passwordEditText = findViewById<EditText>(R.id.password_edittext)

            val username = usernameEditText?.text?.toString()?.trim()
            val password = passwordEditText?.text?.toString()?.trim()

            if (!username.isNullOrEmpty() && !password.isNullOrEmpty()) {
                if (username == userAdmin && password == passwordAdmin) {
                    // Successful login
                    Toast.makeText(this, "Login successful", Toast.LENGTH_SHORT).show()
                    val intent = Intent(this, MainActivity2::class.java)
                    intent.putExtra("username", username)
                    startActivity(intent)
                } else {
                    // Incorrect username or password
                    Toast.makeText(this, "Incorrect username or password", Toast.LENGTH_SHORT).show()
                }
            } else {
                // Username or password is empty
                Toast.makeText(this, "Please enter both username and password", Toast.LENGTH_SHORT).show()
            }
        }


    }
}