package br.com.wktechnology.springboot.dtos;

import br.com.wktechnology.springboot.entities.BloodType;
import br.com.wktechnology.springboot.utils.FormatterHelper;
import lombok.Getter;

@Getter
public class AverageAgeByBloodTypeDTO {
    private final String bloodType;
    private final String averageAge;

    public AverageAgeByBloodTypeDTO(BloodType bloodType, Double averageAge) {
        this.bloodType = bloodType.toString();
        this.averageAge = FormatterHelper.formatAverage(averageAge);
    }
}