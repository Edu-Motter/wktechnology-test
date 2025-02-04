package br.com.wktechnology.springboot.services;

import br.com.wktechnology.springboot.entities.Candidate;
import br.com.wktechnology.springboot.repositories.CandidateRepository;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.bean.override.mockito.MockitoBean;
import org.springframework.test.context.junit4.SpringRunner;

import static org.junit.Assert.*;

@RunWith(SpringRunner.class)
@SpringBootTest(classes = CandidateService.class)
public class CandidateServiceTest {
    @Autowired
    private CandidateService service;

    @MockitoBean
    private CandidateRepository repositoryMock;

    @Test
    public void shouldCalculateBMIWhenHeightAndWeightAreValid() {
        Candidate candidate = new Candidate();
        candidate.setHeightInCentimeters(175);
        candidate.setWeightInGrams(70 * 1000);

        double bmi = service.calculateBMI(candidate);
        String formattedBMI = String.format("%.2f", bmi);
        Assert.assertEquals("22.86", formattedBMI);
    }

    @Test
    public void shouldReturnZeroWhenHeightIsZeroOrNegative() {
        Candidate candidate = new Candidate();
        candidate.setHeightInCentimeters(0);
        candidate.setWeightInGrams(700);

        Double bmi = service.calculateBMI(candidate);
        assertEquals(0.0, bmi, 0.0);
    }

    @Test
    public void shouldReturnZeroWhenWeightIsZeroOrNegative() {
        Candidate candidate = new Candidate();
        candidate.setHeightInCentimeters(180);
        candidate.setWeightInGrams(0);

        Double bmi = service.calculateBMI(candidate);
        assertEquals(0.0, bmi, 0.0);
    }

    @Test
    public void shouldReturnFalseWhenWeightIsBelow50Kg() {
        //Invalid: 45kg X | 20 anos V
        Candidate candidate = new Candidate();
        candidate.setWeightInGrams(45 * 1000);
        candidate.setAge(20);

        boolean isValid = service.isValidCandidate(candidate);
        assertFalse(isValid);
    }

    @Test
    public void shouldReturnFalseWhenAgeIsBelow16() {
        //Invalid: 55Kg V | 15 anos X
        Candidate candidate = new Candidate();
        candidate.setWeightInGrams(55 * 1000);
        candidate.setAge(15);

        boolean isValid = service.isValidCandidate(candidate);
        assertFalse(isValid);
    }

    @Test
    public void shouldReturnFalseWhenAgeIsAbove69() {
        //Invalid: 55kg V | 70 anos X
        Candidate candidate = new Candidate();
        candidate.setWeightInGrams(55 * 1000);
        candidate.setAge(70);

        boolean isValid = service.isValidCandidate(candidate);
        assertFalse(isValid);
    }

    @Test
    public void shouldReturnTrueWhenWeightIsAbove50KgAndAgeIsBetween16And69() {
        //Valid: 55kg V | 18 anos V
        Candidate candidate = new Candidate();
        candidate.setWeightInGrams(55 * 1000);
        candidate.setAge(18);

        boolean isValid = service.isValidCandidate(candidate);
        assertTrue(isValid);
    }

    @Test
    public void shouldReturnFalseWhenWeightIsExactly50KgAndAgeIsBelow16() {
        //Valid: 50kg V | 15 anos X
        Candidate candidate = new Candidate();
        candidate.setWeightInGrams(50 * 1000);
        candidate.setAge(15);

        boolean isValid = service.isValidCandidate(candidate);
        assertFalse(isValid);
    }

    @Test
    public void shouldReturnTrueWhenWeightIsExactly50KgAndAgeIs16() {
        //Valid: 50kg V | 16 anos X
        Candidate candidate = new Candidate();
        candidate.setWeightInGrams(50 * 1000);
        candidate.setAge(16);


        boolean isValid = service.isValidCandidate(candidate);
        assertTrue(isValid);
    }
}