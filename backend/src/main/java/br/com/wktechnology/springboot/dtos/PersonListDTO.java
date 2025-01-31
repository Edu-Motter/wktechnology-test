package br.com.wktechnology.springboot.dtos;

import java.util.List;

public class PersonListDTO {
    private List<PersonJson> people;

    public List<PersonJson> getPeople() {
        return people;
    }

    public void setPeople(List<PersonJson> people) {
        this.people = people;
    }
}