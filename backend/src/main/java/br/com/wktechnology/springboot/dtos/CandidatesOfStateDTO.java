package br.com.wktechnology.springboot.dtos;

import br.com.wktechnology.springboot.entities.State;
import lombok.Getter;
import lombok.Setter;

@Getter
public class CandidatesOfStateDTO {
    private final String state;
    private final String stateFullName;

    private Long numberOfCandidates;

    @Setter
    private Long numberOfValidDonors;

    public CandidatesOfStateDTO(State state, Long numberOfCandidates, Long numberOfValidDonors) {
        this.state = state.name();
        this.stateFullName = state.getFullName();
        this.numberOfCandidates = numberOfCandidates;
        this.numberOfValidDonors = numberOfValidDonors;
    }

    static public CandidatesOfStateDTO empty(State state){
        return new CandidatesOfStateDTO(state, 0L,0L);
    }

    public CandidatesOfStateDTO setNumberOfCandidates(Long numberOfCandidates) {
        this.numberOfCandidates = numberOfCandidates;
        return this;
    }
}
