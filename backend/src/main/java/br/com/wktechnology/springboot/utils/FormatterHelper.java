package br.com.wktechnology.springboot.utils;

import java.text.DecimalFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class FormatterHelper {
    static DecimalFormat averageFormatter = new DecimalFormat("#0.00");
    static DateTimeFormatter dateformatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");

    public static String formatAverage(Double average){
        return averageFormatter.format(average);
    }

    public static LocalDate parseDate(String date){
        return LocalDate.parse(date, dateformatter);
    }
}
