package com.example.mycurrency;

import org.json.JSONException;
import org.json.JSONObject;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;

public class RequestApi {

    private OkHttpClient client = new OkHttpClient();



//GESTISCE L OGGETTO JSON ED ESTRAPPOLA IL TASSO DI CAMBIO
    private double parseRateForEUR1(String responseBody,String currencyTo) {
        try {
            // Converti la risposta JSON in un oggetto JSONObject
            JSONObject jsonResponse = new JSONObject(responseBody);

            // Controlla se la risposta contiene il campo "conversion_rates"
            if (jsonResponse.has("conversion_rates")) {
                // Estrai l'oggetto conversion_rates
                JSONObject conversionRates = jsonResponse.getJSONObject("conversion_rates");
                // Controlla se l'oggetto conversion_rates contiene il tasso di cambio per l'Euro (EUR)
                if (conversionRates.has(currencyTo)) {
                    // Estrai il tasso di conversione per l'Euro (EUR)
                    return conversionRates.getDouble(currencyTo);
                } else {
                    // non c e "EUR"
                    return -1.0;
                }
            } else {
                // non c e "conversion_rates"
                return -1.0;
            }
        } catch (JSONException e) {
            e.printStackTrace();
            // altri errorii
            return -1.0;
        }
    }





//CHIAMATA API CON LA DATA E LE VALUTE IMPOSTATE
    public double getRateForEURday(String baseCurrency,String currencyTo ,Date date) {
        String apiUrl = buildHistoricalUrlForDate(baseCurrency, currencyTo, date);
        System.out.println(apiUrl);

        Request request = new Request.Builder()
                .url(apiUrl)
                .build();

        try {
            Response response = client.newCall(request).execute();

            if (response.isSuccessful()) {
                //stringa di risposta
                String responseBody = response.body().string();
                return parseRateForEUR1(responseBody,currencyTo);
            } else {
                // DEBUG
                return -12.0;
            }
        } catch (IOException e) {
            e.printStackTrace();
            //altri errori
            return -13.0;
        }
    }

//url api (prova pro 2 settimane)
    private String buildHistoricalUrlForDate(String baseCurrency,String currencyTo, Date date) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd", Locale.ITALY);
        String formattedDate = dateFormat.format(date);

        return "https://v6.exchangerate-api.com/v6/1f799cf9341311fda8259c56/history/"
                + baseCurrency + "/" + formattedDate;
    }


}
