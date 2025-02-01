package br.com.wktechnology.springboot.services;

import br.com.wktechnology.springboot.dtos.*;
import br.com.wktechnology.springboot.entities.AgeRange;
import br.com.wktechnology.springboot.entities.BloodType;
import br.com.wktechnology.springboot.repositories.CandidateRepository;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.atomic.AtomicReference;

@Service
public class ReportService {

    private final CandidateRepository candidateRepository;

    public ReportService(CandidateRepository candidateRepository) {
        this.candidateRepository = candidateRepository;
    }

    public List<CandidatesOfStateDTO> getPeopleCountOfEachState(){
        return candidateRepository.countByState();
    }

    public ObesityRateDTO getObesityRate(){
        List<CandidateDTO> bmis = candidateRepository.getCandidates();

        ArrayList<CandidateDTO> men = new ArrayList<>();
        ArrayList<CandidateDTO> obesityMen = new ArrayList<>();
        ArrayList<CandidateDTO> women = new ArrayList<>();
        ArrayList<CandidateDTO> obesityWomen = new ArrayList<>();

        for (CandidateDTO bmi : bmis){
            if (bmi.getGender().toUpperCase().startsWith("F")){
                women.add(bmi);
///             Considerado obeso quem tem IMC > 30
                if (bmi.getBmi() > 30) obesityWomen.add(bmi);
            } else {
                men.add(bmi);
///             Considerado obeso quem tem IMC > 30
                if (bmi.getBmi() > 30) obesityMen.add(bmi);
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

        return new ObesityRateDTO(maleObesityRate, femaleObesityRate);
    }

    public List<AverageAgeByBloodTypeDTO> getAverageAgesByBloodType(){
        List<CandidateBloodTypeAndAgeDTO> dtos = candidateRepository.getCandidatesBloodTypeAndAge();

        Map<BloodType, List<Integer>> bloodTypeMap = new HashMap<>();
        for (CandidateBloodTypeAndAgeDTO candidate : dtos) {
            bloodTypeMap
                    .computeIfAbsent(candidate.getBloodType(), type -> new ArrayList<>())
                    .add(candidate.getAge());
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

    public List<AverageBMIByAgeRangeDTO> getAverageBMIByAgeRange(){
        List<CandidateDTO> candidates = candidateRepository.getCandidates();

        Map<AgeRange, List<Double>> ageRangeMap = new HashMap<>();
        for (CandidateDTO candidate : candidates) {
            final AgeRange ageRange = AgeRange.getAgeRangeOf(candidate.getAge());
            ageRangeMap
                    .computeIfAbsent(ageRange, range -> new ArrayList<>())
                    .add(candidate.getBmi());
        }

        List<AverageBMIByAgeRangeDTO> result = new ArrayList<>();
        for (Map.Entry<AgeRange, List<Double>> entry : ageRangeMap.entrySet()) {
            AgeRange ageRange = entry.getKey();
            List<Double> bmis = entry.getValue();

            double sum = 0.0;
            for (Double bmi : bmis) {
                sum += bmi;
            }
            double averageBmi = bmis.isEmpty() ? 0.0 : sum / bmis.size();

            result.add(new AverageBMIByAgeRangeDTO(ageRange, averageBmi));
        }

        return result;
    }

    public List<NumberOfDonorsByBloodType> getNumberOfDonorsByBloodType(){
        List<DonorsByBloodTypeDTO> donorsByBloodType = candidateRepository.getValidDonorsByBloodType();
        List<NumberOfDonorsByBloodType> result = new ArrayList<>();

        for (BloodType receiverBloodType : BloodType.values()) {
            long totalDonors = 0;

            for (DonorsByBloodTypeDTO donor : donorsByBloodType) {
                if (receiverBloodType.canReceiveFrom(donor.getBloodType())) {
                    totalDonors += donor.getQuantityOfDonors();
                }
            }

            result.add(new NumberOfDonorsByBloodType(receiverBloodType, totalDonors));
        }

        return result;
    }

//   public HashMap<Integer, List<Double>> getAllPeopleBMIAndTheRanges() {
//        List<CandidateDTO> data = candidateRepository.findBMIData();
//
//        HashMap<Integer, List<Double>> report = new HashMap<>();
//
//        for (CandidateDTO person : data) {
//            Integer years = person.getYearsOfLife();
//            double bmi = person.calculateBMI();
//
//            Integer range = years / 10;
//
//            System.out.println("adding person " + person.getYearsOfLife() + " in range: " +range);
//
//            if (report.containsKey(range)) {
//                List<Double> bmis = report.get(range);
//                ArrayList<Double> newBmis = new ArrayList<>();
//                newBmis.addAll(bmis);
//                newBmis.add(bmi);
//                report.put(range,newBmis );
//            } else {
//                report.put(range, List.of(bmi));
//            }
//        }
//
//        System.out.println(report);
//        return report;
//    }
}
