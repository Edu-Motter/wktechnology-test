package br.com.wktechnology.springboot.dtos;

import br.com.wktechnology.springboot.entities.AgeRange;
import br.com.wktechnology.springboot.utils.FormatterHelper;
import lombok.Getter;

@Getter
public class AverageBMIByAgeRangeDTO {
    private final String ageRange;
    private final AgeRange ageRangeType;
    private final Double averageBMI;
    private final String averageBMIFormatted;

    public AverageBMIByAgeRangeDTO(AgeRange ageRange, Double averageBMI) {
        this.ageRange = ageRange.toString();
        this.ageRangeType = ageRange;
        this.averageBMI = averageBMI;
        this.averageBMIFormatted = FormatterHelper.formatAverage(averageBMI);
    }
}