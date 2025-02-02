package br.com.wktechnology.springboot.dtos;

import lombok.Getter;

@Getter
public class ObesityRateDTO {
    private final Double maleObesityRate;
    private final Double  femaleObesityRate;

    public ObesityRateDTO(Double maleObesityRate, Double femaleObesityRate) {
        this.maleObesityRate = maleObesityRate;
        this.femaleObesityRate = femaleObesityRate;
    }
}