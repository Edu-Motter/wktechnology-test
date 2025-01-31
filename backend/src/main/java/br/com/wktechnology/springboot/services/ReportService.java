package br.com.wktechnology.springboot.services;

import br.com.wktechnology.springboot.dtos.PersonBMIDTO;
import br.com.wktechnology.springboot.dtos.CandidatesOfStateDTO;
import br.com.wktechnology.springboot.repositories.PersonRepository;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@Service
public class ReportService {

    private final PersonRepository personRepository;

    public ReportService(PersonRepository personRepository) {
        this.personRepository = personRepository;
    }

    public List<CandidatesOfStateDTO> getPeopleCountOfEachState(){
        return personRepository.countByState();
    }

   public HashMap<Integer, List<Double>> getAllPeopleBMIAndTheRanges() {
        List<PersonBMIDTO> data = personRepository.findBMIData();

        HashMap<Integer, List<Double>> report = new HashMap<>();

        for (PersonBMIDTO person : data) {
            Integer years = person.getYearsOfLife();
            double bmi = person.calculateBMI();

            Integer range = years / 10;

            System.out.println("adding person " + person.getYearsOfLife() + " in range: " +range);

            if (report.containsKey(range)) {
                List<Double> bmis = report.get(range);
                ArrayList<Double> newBmis = new ArrayList<>();
                newBmis.addAll(bmis);
                newBmis.add(bmi);
                report.put(range,newBmis );
            } else {
                report.put(range, List.of(bmi));
            }
        }

        System.out.println(report);
        return report;
    }
}
