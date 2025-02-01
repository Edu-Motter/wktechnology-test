package br.com.wktechnology.springboot.dtos;

import br.com.wktechnology.springboot.entities.BloodType;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class DonorsByBloodTypeDTO {
    private final Long quantityOfDonors;
    private final BloodType bloodType;

    public DonorsByBloodTypeDTO(BloodType bloodType, Long quantityOfDonors) {
        this.bloodType = bloodType;
        this.quantityOfDonors = quantityOfDonors;
    }
}
