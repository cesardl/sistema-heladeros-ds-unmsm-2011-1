package pe.lamborgini.domain.dto;

import pe.lamborgini.domain.mapping.ContratoHeladero;

public class ContratoHeladeroDTO {

    private ContratoHeladero contract;
    private boolean active;
    private String message;

    public ContratoHeladero getContract() {
        return contract;
    }

    public void setContract(ContratoHeladero contract) {
        this.contract = contract;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}
