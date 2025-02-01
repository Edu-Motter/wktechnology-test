package br.com.wktechnology.springboot.dtos;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;

@Getter
@Setter
public class CandidateBMIDTO {
    private Double bmi;
    private String gender;

    public CandidateBMIDTO(Double bmi, String gender) {
        this.bmi =bmi;
        this.gender = gender;

    }
}
