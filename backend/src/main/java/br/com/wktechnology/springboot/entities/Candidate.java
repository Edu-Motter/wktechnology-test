package br.com.wktechnology.springboot.entities;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDate;

@Entity
@Table(name = "candidates")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Candidate {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String name;

    @Column(name = "identity_card")
    private String identityCard;

    @Column(nullable = false, name = "cpf_number", length = 20, unique = true)
    private String cpfNumber;

    @Column(name = "birth_date")
    private LocalDate birthDate;

    @Column(name = "age")
    private Integer age;

    @Column(length = 10)
    private String gender;

    @Column(name = "mother_name")
    private String motherName;

    @Column(name = "father_name")
    private String fatherName;

    @Column
    private String email;

    @Column(length = 9)
    private String zipCode;

    @Column
    private String address;

    @Column(name = "address_number")
    private Integer addressNumber;

    @Column
    private String neighborhood;

    @Column
    private String city;

    @Enumerated(EnumType.STRING)
    @Column(name = "state", length = 2, nullable = false)
    private State state;

    @Column(name = "home_phone")
    private String homePhone;

    @Column(name = "mobile_phone")
    private String mobilePhone;

    @Column(name = "height")
    private Integer heightInCentimeters;

    @Column(name = "weight")
    private Integer weightInGrams;

    @Enumerated(EnumType.STRING)
    @Column(name = "blood_type", length = 3, nullable = false)
    private BloodType bloodType;

    @Column(name = "bmi")
    private Double bmi;

    @Column(name = "valid")
    private Boolean valid;

    @Transient
    public double getHeightInMeters() {
        return heightInCentimeters != null ? (heightInCentimeters / 100.0) : 0.0;
    }

    @Transient
    public double getWeightInKg() {
        return weightInGrams != null ? (weightInGrams / 1000.0) : 0.0;
    }
}