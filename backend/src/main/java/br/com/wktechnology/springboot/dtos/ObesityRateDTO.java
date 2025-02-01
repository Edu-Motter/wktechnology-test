package br.com.wktechnology.springboot.dtos;

import br.com.wktechnology.springboot.utils.FormatterHelper;
import lombok.Getter;
import lombok.Setter;

import java.text.DecimalFormat;

@Getter
public class ObesityRateDTO {
    private final String maleObesityRate;
    private final String  femaleObesityRate;

    public ObesityRateDTO(Double maleObesityRate, Double femaleObesityRate) {
        this.maleObesityRate = FormatterHelper.formatRate(maleObesityRate);
        this.femaleObesityRate = FormatterHelper.formatRate(femaleObesityRate);
    }
}