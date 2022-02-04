package com.example.concerttickets;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Spinner;
import android.widget.TextView;

import java.text.NumberFormat;
import java.util.Locale;

public class MainActivity extends AppCompatActivity {


    double costPerTicket = 0.0;
    int numberOfTickets = 0;
    double totalCost = 0.0;
    String groupChoice = "";



    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        getSupportActionBar().setDisplayHomeAsUpEnabled(true);
        getSupportActionBar().setLogo(R.mipmap.ic_launcher);
        getSupportActionBar().setDisplayUseLogoEnabled(true);

        final EditText tickets = (EditText)findViewById(R.id.txtTickets);
        final Spinner group = (Spinner)findViewById(R.id.txtGroup);
        Button cost = (Button)findViewById(R.id.btnCost);
        cost.setOnClickListener(new View.OnClickListener() {
            final TextView result = ((TextView)findViewById(R.id.txtResult));
            @Override
            public void onClick(View v)
            {
                groupChoice = group.getSelectedItem().toString();
                if(groupChoice.equals("Taylor Swift"))
                {
                    costPerTicket=59.99;
                }
                else if(groupChoice.equals("Miley Cyrus"))
                {
                    costPerTicket=49.99;
                }
                else
                {
                    costPerTicket=39.99;
                }
                numberOfTickets = Integer.parseInt(tickets.getText().toString());
                totalCost = costPerTicket * numberOfTickets;
                NumberFormat nf = NumberFormat.getCurrencyInstance(Locale.US);
                result.setText("Cost for" + groupChoice + "is" + nf.format(totalCost));
            }
        });

    }
}