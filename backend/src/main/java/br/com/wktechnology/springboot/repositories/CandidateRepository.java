package br.com.wktechnology.springboot.repositories;

import br.com.wktechnology.springboot.dtos.CandidateBMIDTO;
import br.com.wktechnology.springboot.dtos.CandidatesOfStateDTO;
import br.com.wktechnology.springboot.entities.Candidate;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface CandidateRepository extends JpaRepository<Candidate, Long> {
    @Query("SELECT new br.com.wktechnology.springboot.dtos.CandidateBMIDTO(c.bmi, c.gender) " +
            "FROM Candidate c")
    List<CandidateBMIDTO> getCandidateBMI();

    @Query("SELECT new br.com.wktechnology.springboot.dtos.CandidatesOfStateDTO(c.state, COUNT(c)) " +
            "FROM Candidate c " +
            "WHERE c.valid = true " +
            "GROUP BY c.state ")
    List<CandidatesOfStateDTO> countByState();
}
