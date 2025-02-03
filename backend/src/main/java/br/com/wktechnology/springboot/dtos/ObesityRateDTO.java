package br.com.wktechnology.springboot.dtos;

import lombok.Getter;

@Getter
public class ObesityRateDTO {
    private final String gender;
    private final Double  obesityRate;

    public ObesityRateDTO(String gender, Double obesityRate) {
        this.gender = gender;
        this.obesityRate = obesityRate;
    }
}