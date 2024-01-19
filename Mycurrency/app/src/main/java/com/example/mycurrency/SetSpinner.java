package com.example.mycurrency;

import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.Spinner;

public class SetSpinner {

    public static void configureSpinnersFromButton(Button button, Spinner spinner1, Spinner spinner2) {
        String buttonText = button.getText().toString();
        String[] parts = buttonText.split("/");

        if (parts.length >= 2) {
            String firstPart = parts[0].trim();
            String secondPart = parts[1].trim();

            int index1 = getIndexForText(spinner1, firstPart);
            spinner1.setSelection(index1);

            int index2 = getIndexForText(spinner2, secondPart);
            spinner2.setSelection(index2);
        }
    }

    private static int getIndexForText(Spinner spinner, String text) {
        ArrayAdapter<String> adapter = (ArrayAdapter<String>) spinner.getAdapter();
        return adapter.getPosition(text);
    }
}
