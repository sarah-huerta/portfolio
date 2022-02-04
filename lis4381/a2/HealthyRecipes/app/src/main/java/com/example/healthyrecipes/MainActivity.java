 package com.example.healthyrecipes;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.widget.Button;

 public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        Button button = (Button)  findViewById(R.id.bttnRecipe);
        button.setOnClickListener((v) ->
        {
            startActivity(new Intent(MainActivity.this, Recipe.class));
        });
    }
}