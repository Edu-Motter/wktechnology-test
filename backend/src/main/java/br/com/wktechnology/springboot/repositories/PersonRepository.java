package br.com.wktechnology.springboot.repositories;

import br.com.wktechnology.springboot.dtos.PersonBMIDTO;
import br.com.wktechnology.springboot.dtos.CandidatesOfStateDTO;
import br.com.wktechnology.springboot.entities.Person;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface PersonRepository extends JpaRepository<Person, Long> {
    @Query("SELECT new br.com.wktechnology.springboot.dtos.PersonBMIDTO(p.birthDate, p.weightInGrams, p.heightInCentimeters) " +
            "FROM Person p")
    List<PersonBMIDTO> findBMIData();

    @Query("SELECT new br.com.wktechnology.springboot.dtos.CandidatesOfStateDTO(p.state, COUNT(p)) " +
            "FROM Person p " +
            "GROUP BY p.state ")
    List<CandidatesOfStateDTO> countByState();
}
