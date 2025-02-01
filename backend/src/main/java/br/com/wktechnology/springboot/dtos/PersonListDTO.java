package br.com.wktechnology.springboot.dtos;

import java.util.List;

public class PersonListDTO {
    private List<CandidateJson> people;

    public List<CandidateJson> getPeople() {
        return people;
    }

    public void setPeople(List<CandidateJson> people) {
        this.people = people;
    }
}