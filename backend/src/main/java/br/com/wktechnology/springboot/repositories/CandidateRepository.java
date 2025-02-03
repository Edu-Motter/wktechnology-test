package br.com.wktechnology.springboot.repositories;

import br.com.wktechnology.springboot.dtos.CandidateDTO;
import br.com.wktechnology.springboot.dtos.CandidateBloodTypeAndAgeDTO;
import br.com.wktechnology.springboot.dtos.CandidatesOfStateDTO;
import br.com.wktechnology.springboot.dtos.DonorsByBloodTypeDTO;
import br.com.wktechnology.springboot.entities.Candidate;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface CandidateRepository extends JpaRepository<Candidate, Long> {
    @Query("SELECT c FROM Candidate c WHERE c.cpfNumber IN :cpfNumbers")
    List<Candidate> findByCpfNumbers(List<String> cpfNumbers);

    @Query("SELECT new br.com.wktechnology.springboot.dtos.CandidateDTO(c.bmi, c.gender, c.age) " +
            "FROM Candidate c")
    List<CandidateDTO> getCandidates();

//    @Query("SELECT new br.com.wktechnology.springboot.dtos.CandidatesOfStateDTO(c.state, COUNT(c)) " +
//            "FROM Candidate c " +
//            "WHERE c.valid = true " +
//            "GROUP BY c.state ")
//    List<CandidatesOfStateDTO> countByState();

    @Query("SELECT new br.com.wktechnology.springboot.dtos.CandidateBloodTypeAndAgeDTO(c.bloodType, c.age) FROM Candidate c")
    List<CandidateBloodTypeAndAgeDTO> getCandidatesBloodTypeAndAge();

    @Query("SELECT new br.com.wktechnology.springboot.dtos.DonorsByBloodTypeDTO(c.bloodType, COUNT(c)) " +
            "FROM Candidate c " +
            "WHERE c.valid = true " +
            "GROUP BY c.bloodType ")
    List<DonorsByBloodTypeDTO> getValidDonorsByBloodType();
}