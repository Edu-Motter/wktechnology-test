package br.com.wktechnology.springboot.dtos;

import br.com.wktechnology.springboot.entities.BloodType;
import lombok.Getter;

@Getter
public class NumberOfDonorsByBloodTypeDTO {
    private final BloodType bloodType;
    private final String bloodTypeLabel;
    private final Long numberOfDonors;

    public NumberOfDonorsByBloodTypeDTO(BloodType bloodType, Long numberOfDonors) {
        this.bloodType = bloodType;
        this.bloodTypeLabel = bloodType.toString();
        this.numberOfDonors = numberOfDonors;
    }
}
