package br.com.wktechnology.springboot.entities;

public enum AgeRange {
    AR10("0 - 10:"),
    AR20("11 - 20:"),
    AR30("21 - 30:"),
    AR40("31 - 40:"),
    AR50("41 - 50:"),
    AR60("51 - 60:"),
    AR70("61 - 70:"),
    AR80("71 - 80:"),
    AR90("81 - 90:"),
    AR100("91 - 100:"),
    ELSE("100+:");

    private final String label;

    AgeRange(String label) {
        this.label = label;
    }

    public static AgeRange getAgeRangeOf(int age) {
        if (age >= 0 && age <= 10) {
            return AgeRange.AR10;
        } else if (age >= 11 && age <= 20) {
            return AgeRange.AR20;
        } else if (age >= 21 && age <= 30) {
            return AgeRange.AR30;
        } else if (age >= 31 && age <= 40) {
            return AgeRange.AR40;
        } else if (age >= 41 && age <= 50) {
            return AgeRange.AR50;
        } else if (age >= 51 && age <= 60) {
            return AgeRange.AR60;
        } else if (age >= 61 && age <= 70) {
            return AgeRange.AR70;
        } else if (age >= 71 && age <= 80) {
            return AgeRange.AR80;
        } else if (age >= 81 && age <= 90) {
            return AgeRange.AR90;
        } else if (age >= 91 && age <= 100) {
            return AgeRange.AR100;
        } else {
            return AgeRange.ELSE;
        }
    }

    @Override
    public String toString() {
        return label;
    }
}
