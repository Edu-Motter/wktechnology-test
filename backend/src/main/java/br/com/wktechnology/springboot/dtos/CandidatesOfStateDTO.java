package br.com.wktechnology.springboot.dtos;

import br.com.wktechnology.springboot.entities.State;
import lombok.Getter;

@Getter
public class CandidatesOfStateDTO {
    private final String state;
    private final String stateFullName;
    private final Long numberOfCandidates;

    public CandidatesOfStateDTO(State state, Long count) {
        this.state = state.name();
        this.stateFullName = state.getFullName();
        this.numberOfCandidates = count;
    }
}
