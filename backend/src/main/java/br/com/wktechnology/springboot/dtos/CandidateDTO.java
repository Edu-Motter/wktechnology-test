package br.com.wktechnology.springboot.dtos;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CandidateDTO {
    private Double bmi;
    private Integer age;
    private String gender;

    public CandidateDTO(Double bmi, String gender, Integer age) {
        this.bmi =bmi;
        this.age =age;
        this.gender = gender;
    }
}
