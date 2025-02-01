package br.com.wktechnology.springboot.dtos;

import br.com.wktechnology.springboot.entities.BloodType;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class NumberOfDonorsByBloodType {
    private final BloodType bloodType;
    private final String bloodTypeLabel;
    private final Long numberOfDonors;

    public NumberOfDonorsByBloodType(BloodType bloodType, Long numberOfDonors) {
        this.bloodType = bloodType;
        this.bloodTypeLabel = bloodType.toString();
        this.numberOfDonors = numberOfDonors;
    }
}
