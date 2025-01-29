package br.com.wktechnology.springboot.entities;

import java.util.Set;
import java.util.EnumSet;

public enum BloodType {
    A_POSITIVE("A+"),
    A_NEGATIVE("A-"),
    B_POSITIVE("B+"),
    B_NEGATIVE("B-"),
    AB_POSITIVE("AB+"),
    AB_NEGATIVE("AB-"),
    O_POSITIVE("O+"),
    O_NEGATIVE("O-");

    private final String label;
    private Set<BloodType> canReceiveFrom;
    private Set<BloodType> canDonateTo;

    BloodType(String label) {
        this.label = label;
    }

    static {
        A_POSITIVE.canReceiveFrom = EnumSet.of(A_POSITIVE, A_NEGATIVE, O_POSITIVE, O_NEGATIVE);
        A_POSITIVE.canDonateTo = EnumSet.of(A_POSITIVE, AB_POSITIVE);

        A_NEGATIVE.canReceiveFrom = EnumSet.of(A_NEGATIVE, O_NEGATIVE);
        A_NEGATIVE.canDonateTo = EnumSet.of(A_NEGATIVE, A_POSITIVE, AB_NEGATIVE, AB_POSITIVE);

        B_POSITIVE.canReceiveFrom = EnumSet.of(B_POSITIVE, B_NEGATIVE, O_POSITIVE, O_NEGATIVE);
        B_POSITIVE.canDonateTo = EnumSet.of(B_POSITIVE, AB_POSITIVE);

        B_NEGATIVE.canReceiveFrom = EnumSet.of(B_NEGATIVE, O_NEGATIVE);
        B_NEGATIVE.canDonateTo = EnumSet.of(B_NEGATIVE, B_POSITIVE, AB_NEGATIVE, AB_POSITIVE);

        AB_POSITIVE.canReceiveFrom = EnumSet.allOf(BloodType.class);
        AB_POSITIVE.canDonateTo = EnumSet.of(AB_POSITIVE);

        AB_NEGATIVE.canReceiveFrom = EnumSet.of(AB_NEGATIVE, A_NEGATIVE, B_NEGATIVE, O_NEGATIVE);
        AB_NEGATIVE.canDonateTo = EnumSet.of(AB_NEGATIVE, AB_POSITIVE);

        O_POSITIVE.canReceiveFrom = EnumSet.of(O_POSITIVE, O_NEGATIVE);
        O_POSITIVE.canDonateTo = EnumSet.of(O_POSITIVE, A_POSITIVE, B_POSITIVE, AB_POSITIVE);

        O_NEGATIVE.canReceiveFrom = EnumSet.of(O_NEGATIVE);
        O_NEGATIVE.canDonateTo = EnumSet.allOf(BloodType.class);
    }

    public Set<BloodType> getCompatibleDonors() {
        return canReceiveFrom;
    }

    public Set<BloodType> getCompatibleRecipients() {
        return canDonateTo;
    }

    public boolean canReceiveFrom(BloodType donor) {
        return canReceiveFrom.contains(donor);
    }

    public boolean canDonateTo(BloodType recipient) {
        return canDonateTo.contains(recipient);
    }

    public static BloodType fromString(String text) {
        for (BloodType bloodType : BloodType.values()) {
            if (bloodType.label.equalsIgnoreCase(text)) {
                return bloodType;
            }
        }
        throw new IllegalArgumentException("Unknown blood type: " + text);
    }

    @Override
    public String toString() {
        return label;
    }
}
