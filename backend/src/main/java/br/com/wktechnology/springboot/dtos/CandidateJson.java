package br.com.wktechnology.springboot.dtos;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CandidateJson {
    @JsonProperty("nome")
    private String nome;

    @JsonProperty("cpf")
    private String cpf;

    @JsonProperty("rg")
    private String rg;

    @JsonProperty("data_nasc")
    private String dataNasc;

    @JsonProperty("sexo")
    private String sexo;

    @JsonProperty("mae")
    private String mae;

    @JsonProperty("pai")
    private String pai;

    @JsonProperty("email")
    private String email;

    @JsonProperty("cep")
    private String cep;

    @JsonProperty("endereco")
    private String endereco;

    @JsonProperty("numero")
    private Integer numero;

    @JsonProperty("bairro")
    private String bairro;

    @JsonProperty("cidade")
    private String cidade;

    @JsonProperty("estado")
    private String estado;

    @JsonProperty("telefone_fixo")
    private String telefoneFixo;

    @JsonProperty("celular")
    private String celular;

    @JsonProperty("altura")
    private double altura;

    @JsonProperty("peso")
    private int peso;

    @JsonProperty("tipo_sanguineo")
    private String tipoSanguineo;
}