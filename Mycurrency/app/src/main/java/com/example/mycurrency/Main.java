package com.example.mycurrency;
import androidx.appcompat.app.AppCompatActivity;

import android.content.Context;
import android.os.Bundle;

import android.util.Pair;
import android.view.KeyEvent;
import android.view.View;
import android.view.inputmethod.EditorInfo;

import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Spinner;
import android.widget.TextView;
import android.view.inputmethod.InputMethodManager;


import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Locale;

public class Main extends AppCompatActivity {

    public RequestApi requestApi = new RequestApi();



    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);


        Spinner spinnerda = findViewById(R.id.spinnerda);
        Spinner spinnera = findViewById(R.id.spinnera);

        EditText edittextnumberda = findViewById(R.id.edittextnumberda);
        TextView textviewa = findViewById(R.id.textViewa);


        //lista preferiti
        List<Pair<String, String>> preferitiList = new ArrayList<>();

        //storico tassi di cambio
        TextView[] storico = new TextView[8];
        storico[0] = findViewById(R.id.storico0);
        storico[1] = findViewById(R.id.storico1);
        storico[2] = findViewById(R.id.storico2);
        storico[3] = findViewById(R.id.storico3);
        storico[4] = findViewById(R.id.storico4);
        storico[5] = findViewById(R.id.storico5);
        storico[6] = findViewById(R.id.storico6);
        storico[7] = findViewById(R.id.storico7);

        //pulsante converti
        Button butttonconverti = findViewById(R.id.buttonconverti);
        //pulsante imposta preferito
        Button setFavorite = findViewById(R.id.setFavorite);
        //pulsante preferiti
        Button[] favorite = new Button[4];
        favorite[0]=findViewById(R.id.preferiti1);
        favorite[1]=findViewById(R.id.preferiti2);
        favorite[2]=findViewById(R.id.preferiti3);
        favorite[3]=findViewById(R.id.preferiti4);



//IMPOSTAZIONE DEGLI SPINNER
        //imposto preferito0
        favorite[0].setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
           SetSpinner.configureSpinnersFromButton(favorite[0], spinnerda, spinnera);
            }
        });
        //imposto preferito1
        favorite[1].setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                SetSpinner.configureSpinnersFromButton(favorite[1], spinnerda, spinnera);
            }
        });
        //imposto preferito2
        favorite[2].setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                SetSpinner.configureSpinnersFromButton(favorite[2], spinnerda, spinnera);
            }
        });
        //imposto preferito3
        favorite[3].setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                SetSpinner.configureSpinnersFromButton(favorite[3], spinnerda, spinnera);
            }
        });




//AGGIUNTA PREFERITI TRAMITE STELLA
        setFavorite.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {

                String selectedValueSpinner1 = spinnerda.getSelectedItem().toString();
                String selectedValueSpinner2 = spinnera.getSelectedItem().toString();

                preferitiList.add(new Pair<>(selectedValueSpinner1, selectedValueSpinner2));

                updatePreferitiButtons();
            }
            private void updatePreferitiButtons() {
                if (preferitiList.size() == 1) {
                favorite[0].setText( preferitiList.get(preferitiList.size() - 1).first + " / " + preferitiList.get(preferitiList.size() - 1).second);
            } else if (preferitiList.size() == 2){
                    favorite[1].setText(preferitiList.get(preferitiList.size()-1).first + " / " + preferitiList.get(preferitiList.size() -1 ).second);
            } else if (preferitiList.size() == 3) {
                    favorite[2].setText(preferitiList.get(preferitiList.size()-1).first + " / " + preferitiList.get(preferitiList.size() -1).second);
             }else if (preferitiList.size() == 4){
                    favorite[3].setText( preferitiList.get(preferitiList.size() -1).first + " / " + preferitiList.get(preferitiList.size()-1).second);
             }
            }
        });




//POPOLO GLI SPINNER
        String[] valute = {"AUD", "EUR", "JPY", "GBP", "USD", "CAD", "CHF", "CNY", "SEK", "NZD"};

        // Crea un ArrayAdapter utilizzando l'array di stringhe e un layout di spinner predefinito
        ArrayAdapter<String> adattatore = new ArrayAdapter<>(this, android.R.layout.simple_spinner_item, valute);

        // layout con piu spazio
        adattatore.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);

        // imposta  Spinner
        spinnera.setAdapter(adattatore);
        spinnerda.setAdapter(adattatore);







//NASCONDE TASTIERA QUANDO SI PREME INVIO
        edittextnumberda.setOnEditorActionListener(new TextView.OnEditorActionListener() {
            @Override
            public boolean onEditorAction(TextView v, int actionId, KeyEvent event) {
                if (actionId == EditorInfo.IME_ACTION_DONE || (event != null && event.getKeyCode() == KeyEvent.KEYCODE_ENTER)) {
                    // Nascondi la tastiera virtuale
                    InputMethodManager imm = (InputMethodManager) getSystemService(Context.INPUT_METHOD_SERVICE);
                    imm.hideSoftInputFromWindow(edittextnumberda.getWindowToken(), 0);
                    return true; // Consuma l'evento
                }
                return false; // Lascia che l'evento venga gestito normalmente
            }
        });








//TASTO CONVERTI
        butttonconverti.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {

// CHIAMATA ASINCRONA con thread
                new Thread(new Runnable() {
                    @Override
                    public void run() {

                       String currencyFrom = spinnerda.getSelectedItem().toString();
                       String currencyTo = spinnera.getSelectedItem().toString();
                        //final String currencyFrom = "EUR";
                       // final String currencyTo = "USD";

                        // data formattata
                        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd", Locale.getDefault());

                        // Ottenere la data odierna
                        Date today = new Date();


                        //reperisco il primo tasso di cambio di oggi
                        double rateForEUR = requestApi.getRateForEURday(currencyFrom,currencyTo,today);

                        // Calcolare le date degli ultimi sette giorni
                        Calendar calendar = Calendar.getInstance();
                        calendar.setTime(today);

                        calendar.add(Calendar.DAY_OF_YEAR, -1);
                        Date yesterday = calendar.getTime();
                        final double rateForEUR1 = requestApi.getRateForEURday(currencyFrom,currencyTo,yesterday);

                        calendar.add(Calendar.DAY_OF_YEAR, -1);
                        Date twoDaysAgo = calendar.getTime();
                        final double rateForEUR2 = requestApi.getRateForEURday(currencyFrom,currencyTo,twoDaysAgo);

                        calendar.add(Calendar.DAY_OF_YEAR, -1);
                        Date threeDaysAgo = calendar.getTime();
                        final double rateForEUR3 = requestApi.getRateForEURday(currencyFrom,currencyTo,threeDaysAgo);

                        calendar.add(Calendar.DAY_OF_YEAR, -1);
                        Date fourDaysAgo = calendar.getTime();
                        final double rateForEUR4 = requestApi.getRateForEURday(currencyFrom,currencyTo,fourDaysAgo);

                        calendar.add(Calendar.DAY_OF_YEAR, -1);
                        Date fiveDaysAgo = calendar.getTime();
                        final double rateForEUR5 = requestApi.getRateForEURday(currencyFrom,currencyTo,fiveDaysAgo);


                        calendar.add(Calendar.DAY_OF_YEAR, -1);
                        Date sixDaysAgo = calendar.getTime();
                        final double rateForEUR6 = requestApi.getRateForEURday(currencyFrom,currencyTo,sixDaysAgo);

                        calendar.add(Calendar.DAY_OF_YEAR, -1);
                        Date sevenDaysAgo = calendar.getTime();
                        final double rateForEUR7 = requestApi.getRateForEURday(currencyFrom, currencyTo, sevenDaysAgo);



                        runOnUiThread(new Runnable() {
                            @Override
                            public void run() {
                                if (rateForEUR != -1.0) {

                                    storico[0].setText("Tasso di cambio OGGI: " + rateForEUR);
                                    storico[1].setText("Tasso di cambio IERI: " + rateForEUR1);
                                    storico[2].setText("Tasso di cambio 2 GIORNI FA: " + rateForEUR2);
                                    storico[3].setText("Tasso di cambio 3 GIORNI FA: " + rateForEUR3);
                                    storico[4].setText("Tasso di cambio 4 GIORNI FA: " + rateForEUR4);
                                    storico[5].setText("Tasso di cambio 5 GIORNI FA: " + rateForEUR5);
                                    storico[6].setText("Tasso di cambio 6 GIORNI FA: " + rateForEUR6);
                                    storico[7].setText("Tasso di cambio 7 GIORNI FA: " + rateForEUR7);

                                    String inputValue = edittextnumberda.getText().toString();
                                        // Converte stringa in double
                                        double inputDouble = Double.parseDouble(inputValue);
                                        // Moltiplica per il tasso attuale
                                        double result = inputDouble * rateForEUR;

                                    // cifre decimali
                                    DecimalFormat decimalFormat = new DecimalFormat("#.##");
                                    String formattedResult = decimalFormat.format(result);

                                    // Mostra il risultato nella TextView
                                        textviewa.setText("Risultato: " + formattedResult);

                                } else {
                                   // storico[0].setText("Errore ");
                                }
                            }
                        });
                    }
                }).start();
            }
        });
    }
    }




















