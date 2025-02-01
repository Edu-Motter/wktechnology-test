package br.com.wktechnology.springboot.services;

import br.com.wktechnology.springboot.dtos.CandidateJson;
import br.com.wktechnology.springboot.entities.BloodType;
import br.com.wktechnology.springboot.entities.Candidate;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

@Service
public class CandidateService {

    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
    //TODO: Unit test in this service

    public List<Candidate> parseJsonListToCandidateList(List<CandidateJson> jsonList) {


        List<Candidate> candidates = new ArrayList<>();
        for (CandidateJson json : jsonList){

            LocalDate birthDate = LocalDate.parse(json.getDataNasc(), formatter);

            Candidate candidate = new Candidate();
            candidate.setName(json.getNome());
            candidate.setCpfNumber(json.getCpf());
            candidate.setIdentityCard(json.getRg());
            candidate.setBirthDate(birthDate);
            candidate.setAge(calculateAge(birthDate));
            candidate.setGender(json.getSexo());
            candidate.setMotherName(json.getMae());
            candidate.setFatherName(json.getPai());
            candidate.setEmail(json.getEmail());
            candidate.setZipCode(json.getCep());
            candidate.setAddress(json.getEndereco());
            candidate.setAddressNumber(json.getNumero());
            candidate.setNeighborhood(json.getBairro());
            candidate.setCity(json.getCidade());
            candidate.setState(json.getEstado());
            candidate.setHomePhone(json.getTelefoneFixo());
            candidate.setMobilePhone(json.getCelular());
            candidate.setHeightInCentimeters((int) (json.getAltura() * 100));
            candidate.setWeightInGrams(json.getPeso() * 1000);
            candidate.setBloodType(BloodType.fromString(json.getTipoSanguineo()));

            candidate.setValid(isValidCandidate(candidate));
            candidate.setBmi(calculateBMI(candidate));

            candidates.add(candidate);
        }

        return candidates;
    }

    private boolean isValidCandidate(Candidate candidate){
        /// Somente com peso acima de 50 Kg podem doar sangue
        double weightInKg = candidate.getWeightInKg();
        if (weightInKg < 50) return false;

        /// Somente pessoas com idade de 16 a 69 anos podem doar sangue
        int age = candidate.getAge();
        System.out.println("age: " + age + " birth: " + candidate.getBirthDate().format(formatter) );
        return age >= 16 && age <= 69;
    }

    private int calculateAge(LocalDate birthDate) {
        LocalDate now = LocalDate.now();

        //2025 - 2000 => 25
        int age = now.getYear() - birthDate.getYear();
        //now: 30/(01) < 15/(05)
        if (now.getMonthValue() < birthDate.getMonthValue()){
            age--;
            return age;
        }
        //now: 30/01 | birth 31/01: month 01 == month 01 | now day: 30 < birth:31
        if (now.getMonthValue() == birthDate.getMonthValue() && now.getDayOfMonth() < birthDate.getDayOfMonth()){
            age--;
            return age;
        }
        return age;
    }

    private Double calculateBMI(Candidate candidate) {
        double heightInMeters = candidate.getHeightInMeters();
        double weightInKg = candidate.getWeightInKg();

        ///heightInMeters must be higher than 0, division by zero is not allowed
        if (heightInMeters <= 0) return 0.0;

        return (weightInKg / (heightInMeters * heightInMeters));
    }
}
