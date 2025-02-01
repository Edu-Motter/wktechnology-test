package br.com.wktechnology.springboot.utils;

import java.text.DecimalFormat;

public class FormatterHelper {
    static DecimalFormat rateFormatter = new DecimalFormat("#0.00%");

    public static String formatRate(Double rate){
        return rateFormatter.format(rate);
    }
}
