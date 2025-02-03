package br.com.wktechnology.springboot.entities;

public enum AgeRange {
    AR10(0, 10, "0 - 10"),
    AR20(11, 20, "11 - 20"),
    AR30(21, 30, "21 - 30"),
    AR40(31, 40, "31 - 40"),
    AR50(41, 50, "41 - 50"),
    AR60(51, 60, "51 - 60"),
    AR70(61, 70, "61 - 70"),
    AR80(71, 80, "71 - 80"),
    AR90(81, 90, "81 - 90"),
    AR100(91, 100, "91 - 100"),
    ELSE(101, 250, "100+");

    private final int startAge;
    private final int endAge;
    private final String label;

    AgeRange(int startAge, int endAge, String label) {
        this.startAge = startAge;
        this.endAge = endAge;
        this.label = label;
    }

    public static AgeRange getAgeRangeOf(int age) {
        for (AgeRange range : values()) {
            if (age >= range.startAge && age <= range.endAge) {
                return range;
            }
        }
        return ELSE;
    }

    @Override
    public String toString() {
        return label;
    }
}
