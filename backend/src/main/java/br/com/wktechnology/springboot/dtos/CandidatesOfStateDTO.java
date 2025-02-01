package br.com.wktechnology.springboot.dtos;

import lombok.Getter;
import lombok.Setter;

@Getter
public class CandidatesOfStateDTO {
    private final String state;
    private final Long numberOfCandidates;

    public CandidatesOfStateDTO(String state, Long count) {
        this.state = state;
        this.numberOfCandidates = count;
    }
}
