package br.com.wktechnology.springboot.services;

import br.com.wktechnology.springboot.dtos.*;
import br.com.wktechnology.springboot.entities.AgeRange;
import br.com.wktechnology.springboot.entities.BloodType;
import br.com.wktechnology.springboot.entities.Candidate;
import br.com.wktechnology.springboot.entities.State;
import br.com.wktechnology.springboot.repositories.CandidateRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ReportService {

    @Autowired
    private final CandidateRepository repository;

    public ReportService(CandidateRepository repository) {
        this.repository = repository;
    }

    public List<CandidatesOfStateDTO> getPeopleCountOfEachState(){
        final List<Candidate> candidates = repository.findAll();

        Map<State, CandidatesOfStateDTO> dtoHashMap = new HashMap<>();

        for (Candidate candidate : candidates) {
            final CandidatesOfStateDTO emptyDTO = dtoHashMap.getOrDefault(candidate.getState(), CandidatesOfStateDTO.empty(candidate.getState()));
            final int isValidDonor = candidate.getValid() ? 1 : 0;
            dtoHashMap
                    .computeIfAbsent(candidate.getState(), type -> emptyDTO)
                    .setNumberOfCandidates(emptyDTO.getNumberOfCandidates() + 1)
                    .setNumberOfValidDonors(emptyDTO.getNumberOfValidDonors() + isValidDonor);
        }

        return dtoHashMap.values().stream().toList();
    }

    public List<AverageBMIByAgeRangeDTO> getAverageBMIByAgeRange(){
        List<CandidateDTO> candidates = repository.getCandidates();

        Map<AgeRange, List<Double>> ageRangeMap = new HashMap<>();
        for (CandidateDTO candidate : candidates) {
            final AgeRange ageRange = AgeRange.getAgeRangeOf(candidate.age());
            ageRangeMap
                    .computeIfAbsent(ageRange, range -> new ArrayList<>())
                    .add(candidate.bmi());
        }

        List<AverageBMIByAgeRangeDTO> result = new ArrayList<>();
        for (Map.Entry<AgeRange, List<Double>> entry : ageRangeMap.entrySet()) {
            AgeRange ageRange = entry.getKey();
            List<Double> bodyMassIndexes = entry.getValue();

            double sum = 0.0;
            for (Double bodyMassIndex : bodyMassIndexes) {
                sum += bodyMassIndex;
            }

            double averageBMI = bodyMassIndexes.isEmpty() ? 0.0 : sum / bodyMassIndexes.size();
            result.add(new AverageBMIByAgeRangeDTO(ageRange, averageBMI));
        }

        return result;
    }

    public List<ObesityRateByGenderDTO> getObesityRateByGender(){
        List<CandidateDTO> candidates = repository.getCandidates();

        ArrayList<CandidateDTO> men = new ArrayList<>();
        ArrayList<CandidateDTO> obesityMen = new ArrayList<>();
        ArrayList<CandidateDTO> women = new ArrayList<>();
        ArrayList<CandidateDTO> obesityWomen = new ArrayList<>();

        /// Considerado obeso quem tem IMC > 30
        for (CandidateDTO candidate : candidates){
            if (candidate.gender().toUpperCase().startsWith("F")){
                women.add(candidate);
                if (candidate.bmi() > 30) obesityWomen.add(candidate);
            }

            if (candidate.gender().toUpperCase().startsWith("M")) {
                men.add(candidate);
                if (candidate.bmi() > 30) obesityMen.add(candidate);
            }
        }

        double maleObesityRate = 0.0;
        if (!men.isEmpty()){
            maleObesityRate  = (double) obesityMen.size() / men.size();
        }

        double femaleObesityRate = 0.0;
        if (!women.isEmpty()){
            femaleObesityRate  = (double) obesityWomen.size() / women.size();
        }

        return List.of(new ObesityRateByGenderDTO("women", femaleObesityRate), new ObesityRateByGenderDTO("men", maleObesityRate));
    }

    public List<AverageAgeByBloodTypeDTO> getAverageAgeByBloodType(){
        List<CandidateBloodTypeAndAgeDTO> candidates = repository.getCandidatesBloodTypeAndAge();

        Map<BloodType, List<Integer>> bloodTypeMap = new HashMap<>();
        for (CandidateBloodTypeAndAgeDTO candidate : candidates) {
            bloodTypeMap
                    .computeIfAbsent(candidate.bloodType(), type -> new ArrayList<>())
                    .add(candidate.age());
        }

        List<AverageAgeByBloodTypeDTO> result = new ArrayList<>();
        for (Map.Entry<BloodType, List<Integer>> entry : bloodTypeMap.entrySet()) {
            BloodType bloodType = entry.getKey();
            List<Integer> ages = entry.getValue();
            int sum = 0;
            for (Integer age : ages) {
                sum += age;
            }
            double averageAge = ages.isEmpty() ? 0.0 : (double) sum / ages.size();
            result.add(new AverageAgeByBloodTypeDTO(bloodType, averageAge));
        }
        return result;
    }

    public List<NumberOfDonorsByBloodTypeDTO> getNumberOfDonorsByBloodType(){
        List<NumberOfDonorsByBloodTypeDTO> donorsByBloodType = repository.getValidDonorsByBloodType();

        List<NumberOfDonorsByBloodTypeDTO> result = new ArrayList<>();
        for (BloodType receiverBloodType : BloodType.values()) {
            long totalDonors = 0;

            for (NumberOfDonorsByBloodTypeDTO donor : donorsByBloodType) {
                if (receiverBloodType.canReceiveFrom(donor.getBloodType())) {
                    totalDonors += donor.getNumberOfDonors();
                }
            }

            result.add(new NumberOfDonorsByBloodTypeDTO(receiverBloodType, totalDonors));
        }

        return result;
    }
}
