package br.com.wktechnology.springboot.controllers.responses;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class JsonUploadResponse {
    private String fileName;
    private Long fileSize;
    private String message;

    public JsonUploadResponse(String fileName, Long fileSize, String message) {
        this.fileName = fileName;
        this.fileSize = fileSize;
        this.message = message;
    }
}
