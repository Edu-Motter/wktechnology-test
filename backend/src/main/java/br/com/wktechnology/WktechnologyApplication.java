package br.com.wktechnology;

import br.com.wktechnology.springboot.entities.BloodType;
import br.com.wktechnology.springboot.entities.Candidate;
import br.com.wktechnology.springboot.repositories.CandidateRepository;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Bean;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

@SpringBootApplication
public class WktechnologyApplication {

    public static void main(String[] args) {
        SpringApplication.run(WktechnologyApplication.class, args);
    }

    @Bean
    public CommandLineRunner commandLineRunner(ApplicationContext ctx, CandidateRepository repository) {
        return args -> {
            System.out.println("Spring a boot running in http://localhost:8080");
            List<Candidate> candidateList = repository.findAll();
            System.out.println("List of people:" + candidateList);
            candidateList.forEach(p -> System.out.println(p.getName() + " - " + p.getGender()));

            Candidate candidate = new Candidate();
            candidate.setName("Milena Analu Pires");
            candidate.setCpfNumber("775.256.099-50");
            candidate.setIdentityCard("44.084.541-5");
            candidate.setBirthDate(LocalDate.parse("23/05/1964", DateTimeFormatter.ofPattern("dd/MM/yyyy")));
            candidate.setGender("Feminino");
            candidate.setMotherName("Isadora Marli");
            candidate.setFatherName("Noah Severino César Pires");
            candidate.setEmail("mmilenaanalupires@keffin.com.br");
            candidate.setZipCode("39801-678");
            candidate.setAddress("Rua Kurt W. Rothe");
            candidate.setAddressNumber(675);
            candidate.setNeighborhood("Castro Pires");
            candidate.setCity("Teófilo Otoni");
            candidate.setState("MG");
            candidate.setHomePhone("(33) 3611-4613");
            candidate.setMobilePhone("(33) 98481-0191");
            candidate.setHeightInCentimeters((int) (1.53 * 100));
            candidate.setWeightInGrams(80 * 1000);
            candidate.setBloodType(BloodType.fromString("O-"));

//            repository.save(person);
//            System.out.println("Inserted: " + person.getName() + " - " + person.getBloodType());
        };
    }
}
