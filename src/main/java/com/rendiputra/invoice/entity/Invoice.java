package com.rendiputra.invoice.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Data;
import org.hibernate.annotations.SQLDelete;
import org.hibernate.annotations.SQLRestriction;

import java.math.BigDecimal;
import java.time.LocalDate;

@Entity @Data
@SQLDelete(sql = "UPDATE invoice  SET status_record = 'INACTIVE' WHERE id=?")
//@Where(clause = "deleted = false") // deprecated
@SQLRestriction("status_record <> 'INACTIVE'")
public class Invoice extends BaseEntity{
    @NotNull
    @ManyToOne @JoinColumn(name = "id_invoice_type")
    private InvoiceType invoiceType;

    @NotNull @NotEmpty @Size(min = 3, max = 100)
    private String invoiceNumber;

    @NotNull
    private LocalDate dueDate;

    @NotNull @NotEmpty @Size(min = 3, max = 255)
    private String description;

    @NotNull @Min(0)
    private BigDecimal amount;

    @NotNull
    private Boolean paid = false;
}
