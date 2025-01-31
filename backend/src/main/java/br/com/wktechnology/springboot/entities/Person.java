package br.com.wktechnology.springboot.entities;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDate;

@Entity
@Table(name = "people")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Person {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, length = 100)
    private String name;

    @Column(nullable = false, length = 14, unique = true)
    private String documentId;  // CPF

    @Column(length = 20)
    private String identityCard;  // RG

    @Column(name = "birth_date")
    private LocalDate birthDate;

    @Column(length = 10)
    private String gender;

    @Column(name = "mother_name", length = 100)
    private String motherName;

    @Column(name = "father_name", length = 100)
    private String fatherName;

    @Column(length = 100)
    private String email;

    @Column(length = 9)
    private String zipCode;

    @Column(length = 100)
    private String address;

    @Column(name = "address_number")
    private Integer addressNumber;

    @Column(length = 100)
    private String neighborhood;

    @Column(length = 100)
    private String city;

    @Column(length = 2)
    private String state;

    @Column(name = "home_phone", length = 15)
    private String homePhone;

    @Column(name = "mobile_phone", length = 15)
    private String mobilePhone;

    @Column(name = "height")
    private Integer heightInCentimeters;  // Store height in centimeters

    @Column(name = "weight")
    private Integer weightInGrams;  // Store weight in grams

    @Transient
    public double getHeightInMeters() {
        return heightInCentimeters != null ? (heightInCentimeters / 100.0) : 0.0;
    }

    public void setHeightInCentimeters(int heightInCm) {
        this.heightInCentimeters = heightInCm;
    }

    @Transient
    public double getWeightInKg() {
        return weightInGrams != null ? (weightInGrams / 1000.0) : 0.0;
    }

    public void setWeightInGrams(int weightInGrams) {
        this.weightInGrams = weightInGrams;
    }

    @Enumerated(EnumType.STRING)
    @Column(name = "blood_type", length = 3, nullable = false)
    private BloodType bloodType;
}