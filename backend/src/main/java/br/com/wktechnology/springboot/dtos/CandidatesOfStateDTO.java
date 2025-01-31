package br.com.wktechnology.springboot.dtos;

public class CandidatesOfStateDTO {
    private String state;
    private Long count;

    public CandidatesOfStateDTO(String state, Long count) {
        this.state = state;
        this.count = count;
    }

    // Getters
    public String getState() {
        return state;
    }

    public Long getCount() {
        return count;
    }
}
