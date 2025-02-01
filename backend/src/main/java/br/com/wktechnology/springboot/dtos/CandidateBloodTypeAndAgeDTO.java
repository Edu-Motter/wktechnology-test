package br.com.wktechnology.springboot.dtos;

import br.com.wktechnology.springboot.entities.BloodType;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CandidateBloodTypeAndAgeDTO {
    private BloodType bloodType;
    private Integer age;

    public CandidateBloodTypeAndAgeDTO(BloodType bloodType, Integer age) {
        this.bloodType = bloodType;
        this.age = age;
    }
}

