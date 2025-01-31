package br.com.wktechnology;

import br.com.wktechnology.springboot.dtos.PersonJson;
import br.com.wktechnology.springboot.entities.BloodType;
import br.com.wktechnology.springboot.entities.Person;
import br.com.wktechnology.springboot.entities.Student;
import br.com.wktechnology.springboot.repositories.PersonRepository;
import br.com.wktechnology.springboot.repositories.StudentRepository;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Bean;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.stream.Collectors;

@SpringBootApplication
public class WktechnologyApplication {

    public static void main(String[] args) {
        SpringApplication.run(WktechnologyApplication.class, args);
    }

    @Bean
    public CommandLineRunner commandLineRunner(ApplicationContext ctx, PersonRepository repository) {
        return args -> {
            System.out.println("Spring a boot running in http://localhost:8080");
            List<Person> personList = repository.findAll();
            System.out.println("List of people:" + personList.toString());
            personList.forEach(p -> System.out.println(p.getName() + " - " + p.getGender()));

            Person person = new Person();
            person.setName("Milena Analu Pires");
            person.setDocumentId("775.256.099-50");
            person.setIdentityCard("44.084.541-5");
            person.setBirthDate(LocalDate.parse("23/05/1964", DateTimeFormatter.ofPattern("dd/MM/yyyy")));
            person.setGender("Feminino");
            person.setMotherName("Isadora Marli");
            person.setFatherName("Noah Severino César Pires");
            person.setEmail("mmilenaanalupires@keffin.com.br");
            person.setZipCode("39801-678");
            person.setAddress("Rua Kurt W. Rothe");
            person.setAddressNumber(675);
            person.setNeighborhood("Castro Pires");
            person.setCity("Teófilo Otoni");
            person.setState("MG");
            person.setHomePhone("(33) 3611-4613");
            person.setMobilePhone("(33) 98481-0191");
            person.setHeightInCentimeters((int) (1.53 * 100));
            person.setWeightInGrams(80 * 1000);
            person.setBloodType(BloodType.fromString("O-"));

//            repository.save(person);
//            System.out.println("Inserted: " + person.getName() + " - " + person.getBloodType());
        };
    }

    public static List<Person> convertToPersonList(List<PersonJson> jsonList) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");

        return jsonList.stream().map(json -> {
            Person person = new Person();
            person.setName(json.getNome());
            person.setDocumentId(json.getCpf());
            person.setIdentityCard(json.getRg());
            person.setBirthDate(LocalDate.parse(json.getDataNasc(), formatter));
            person.setGender(json.getSexo());
            person.setMotherName(json.getMae());
            person.setFatherName(json.getPai());
            person.setEmail(json.getEmail());
            person.setZipCode(json.getCep());
            person.setAddress(json.getEndereco());
            person.setAddressNumber(json.getNumero());
            person.setNeighborhood(json.getBairro());
            person.setCity(json.getCidade());
            person.setState(json.getEstado());
            person.setHomePhone(json.getTelefoneFixo());
            person.setMobilePhone(json.getCelular());
            person.setHeightInCentimeters((int) (json.getAltura() * 100));
            person.setWeightInGrams(json.getPeso() * 1000);
            person.setBloodType(BloodType.fromString(json.getTipoSanguineo()));

            return person;
        }).collect(Collectors.toList());
    }
}
