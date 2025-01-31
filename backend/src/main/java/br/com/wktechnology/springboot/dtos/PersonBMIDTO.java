package br.com.wktechnology.springboot.dtos;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;

@Getter
@Setter
public class PersonBMIDTO {
    private LocalDate birthDate;
    private Integer weightInGrams;
    private Integer heightInCentimeters;

    public PersonBMIDTO(LocalDate birthDate, Integer weightInGrams, Integer heightInCentimeters) {
        this.birthDate = birthDate;
        this.weightInGrams = weightInGrams;
        this.heightInCentimeters = heightInCentimeters;
    }

    public double getHeightInMeters() {
        return heightInCentimeters != null ? (heightInCentimeters / 100.0) : 0.0;
    }

    public double getWeightInKg() {
        return weightInGrams != null ? (weightInGrams / 1000.0) : 0.0;
    }

    public Integer getYearsOfLife(){
        return  LocalDate.now().getYear() - birthDate.getYear();
    }

    public double calculateBMI() {
        double heightInMeters = getHeightInMeters();
        double weightInKg = getWeightInKg();
        return (heightInMeters != 0) ? (weightInKg / (heightInMeters * heightInMeters)) : 0.0;
    }
}
