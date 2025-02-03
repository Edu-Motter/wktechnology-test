package br.com.wktechnology.springboot.services;

import br.com.wktechnology.springboot.dtos.CandidateJson;
import br.com.wktechnology.springboot.entities.BloodType;
import br.com.wktechnology.springboot.entities.Candidate;
import br.com.wktechnology.springboot.entities.State;
import br.com.wktechnology.springboot.repositories.CandidateRepository;
import br.com.wktechnology.springboot.utils.FormatterHelper;
import jakarta.transaction.Transactional;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class CandidateService {

    @Autowired
    CandidateRepository repository;

    private final Logger log = LoggerFactory.getLogger(CandidateService.class);

    public List<Candidate> parseJsonListToCandidateList(List<CandidateJson> jsonList) {
        List<Candidate> candidates = new ArrayList<>();
        for (CandidateJson json : jsonList){

            LocalDate birthDate = FormatterHelper.parseDate(json.getDataNasc());

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
            candidate.setState(State.fromAbbreviation(json.getEstado()));
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
        if (candidate.getWeightInKg() < 50) return false;
        /// Somente pessoas com idade de 16 a 69 anos podem doar sangue
        return candidate.getAge() >= 16 && candidate.getAge() <= 69;
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
        if (heightInMeters <= 0) return 0.0;
        return (candidate.getWeightInKg() / (heightInMeters * heightInMeters));
    }

    @Transactional
    public void saveInBatch(List<Candidate> newCandidates) {
        List<String> cpfNumbers = newCandidates.stream()
                .map(Candidate::getCpfNumber)
                .collect(Collectors.toList());

        List<Candidate> existingCandidates = repository.findByCpfNumbers(cpfNumbers);

        Map<String, Candidate> existingCandidateMap = existingCandidates.stream()
                .collect(Collectors.toMap(Candidate::getCpfNumber, candidate -> candidate));

        List<Candidate> toUpdate = new ArrayList<>();
        List<Candidate> toInsert = new ArrayList<>();

        for (Candidate newCandidate : newCandidates) {
            Candidate existingCandidate = existingCandidateMap.get(newCandidate.getCpfNumber());

            if (existingCandidate != null) {
                updateCandidateFields(existingCandidate, newCandidate);
                toUpdate.add(existingCandidate);
            } else {
                toInsert.add(newCandidate);
            }
        }

        if (!toUpdate.isEmpty()) {
            repository.saveAll(toUpdate);
        }
        if (!toInsert.isEmpty()) {
            repository.saveAll(toInsert);
        }
        log.info("success save (inserts: {} & updates: {})", toInsert.size(), toUpdate.size());
    }

    private void updateCandidateFields(Candidate existing, Candidate newData) {
        if (newData.getName() != null) existing.setName(newData.getName());
        if (newData.getIdentityCard() != null) existing.setIdentityCard(newData.getIdentityCard());
        if (newData.getBirthDate() != null) existing.setBirthDate(newData.getBirthDate());
        if (newData.getAge() != null) existing.setAge(newData.getAge());
        if (newData.getGender() != null) existing.setGender(newData.getGender());
        if (newData.getMotherName() != null) existing.setMotherName(newData.getMotherName());
        if (newData.getFatherName() != null) existing.setFatherName(newData.getFatherName());
        if (newData.getEmail() != null) existing.setEmail(newData.getEmail());
        if (newData.getZipCode() != null) existing.setZipCode(newData.getZipCode());
        if (newData.getAddress() != null) existing.setAddress(newData.getAddress());
        if (newData.getAddressNumber() != null) existing.setAddressNumber(newData.getAddressNumber());
        if (newData.getNeighborhood() != null) existing.setNeighborhood(newData.getNeighborhood());
        if (newData.getCity() != null) existing.setCity(newData.getCity());
        if (newData.getState() != null) existing.setState(newData.getState());
        if (newData.getHomePhone() != null) existing.setHomePhone(newData.getHomePhone());
        if (newData.getMobilePhone() != null) existing.setMobilePhone(newData.getMobilePhone());
        if (newData.getHeightInCentimeters() != null) existing.setHeightInCentimeters(newData.getHeightInCentimeters());
        if (newData.getWeightInGrams() != null) existing.setWeightInGrams(newData.getWeightInGrams());
        if (newData.getBloodType() != null) existing.setBloodType(newData.getBloodType());
        if (newData.getBmi() != null) existing.setBmi(newData.getBmi());
        if (newData.getValid() != null) existing.setValid(newData.getValid());
    }
}
