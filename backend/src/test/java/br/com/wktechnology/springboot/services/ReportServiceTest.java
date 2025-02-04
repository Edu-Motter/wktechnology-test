package br.com.wktechnology.springboot.services;

import br.com.wktechnology.springboot.dtos.AverageAgeByBloodTypeDTO;
import br.com.wktechnology.springboot.dtos.CandidateBloodTypeAndAgeDTO;
import br.com.wktechnology.springboot.entities.BloodType;
import br.com.wktechnology.springboot.repositories.CandidateRepository;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.bean.override.mockito.MockitoBean;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.Arrays;
import java.util.Comparator;
import java.util.List;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.mockito.Mockito.when;

@RunWith(SpringRunner.class)
@SpringBootTest(classes = ReportService.class)
public class ReportServiceTest {
    @Autowired
    private ReportService service;

    @MockitoBean
    private CandidateRepository repositoryMock;

    @Test
    public void shouldReturnAverageAgeByBloodType() {
        List<CandidateBloodTypeAndAgeDTO> mockCandidates = Arrays.asList(
                new CandidateBloodTypeAndAgeDTO(BloodType.A_POSITIVE, 25),
                new CandidateBloodTypeAndAgeDTO(BloodType.A_POSITIVE, 30),
                new CandidateBloodTypeAndAgeDTO(BloodType.B_POSITIVE, 40),
                new CandidateBloodTypeAndAgeDTO(BloodType.B_POSITIVE, 45),
                new CandidateBloodTypeAndAgeDTO(BloodType.O_POSITIVE, 35)
        );
        when(repositoryMock.getCandidatesBloodTypeAndAge()).thenReturn(mockCandidates);

        List<AverageAgeByBloodTypeDTO> result = service.getAverageAgeByBloodType();

        assertNotNull(result);
        assertEquals(3, result.size());
        result.sort(Comparator.comparing(o -> o.getBloodType().name()));

        //BloodType.A_POSITIVE: (25 + 30) / 2 = 27.5
        assertEquals(BloodType.A_POSITIVE, result.get(0).getBloodType());
        assertEquals(27.5, result.get(0).getAverageAge(), 0.1);

        //BloodType.B_POSITIVE: (40 + 45) / 2 = 42.5
        assertEquals(BloodType.B_POSITIVE, result.get(1).getBloodType());
        assertEquals(42.5, result.get(1).getAverageAge(), 0.1);

        //BloodType.O_POSITIVE: 35 (only last candidate)
        assertEquals(BloodType.O_POSITIVE, result.get(2).getBloodType());
        assertEquals(35.0, result.get(2).getAverageAge(), 0.1);
    }
}