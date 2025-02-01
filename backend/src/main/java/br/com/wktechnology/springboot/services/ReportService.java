package br.com.wktechnology.springboot.services;

import br.com.wktechnology.springboot.dtos.CandidateBMIDTO;
import br.com.wktechnology.springboot.dtos.CandidatesOfStateDTO;
import br.com.wktechnology.springboot.dtos.ObesityRateDTO;
import br.com.wktechnology.springboot.repositories.CandidateRepository;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

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
        List<CandidateBMIDTO> bmis = candidateRepository.getCandidateBMI();

        ArrayList<CandidateBMIDTO> men = new ArrayList<>();
        ArrayList<CandidateBMIDTO> obesityMen = new ArrayList<>();
        ArrayList<CandidateBMIDTO> women = new ArrayList<>();
        ArrayList<CandidateBMIDTO> obesityWomen = new ArrayList<>();

        for (CandidateBMIDTO bmi : bmis){
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

//   public HashMap<Integer, List<Double>> getAllPeopleBMIAndTheRanges() {
//        List<CandidateBMIDTO> data = candidateRepository.findBMIData();
//
//        HashMap<Integer, List<Double>> report = new HashMap<>();
//
//        for (CandidateBMIDTO person : data) {
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
