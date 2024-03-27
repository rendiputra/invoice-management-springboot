package com.rendiputra.invoice.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Data;
import org.hibernate.annotations.SQLDelete;
import org.hibernate.annotations.SQLRestriction;

@Data @Entity
@SQLDelete(sql = "UPDATE virtual_account  SET status_record = 'INACTIVE' WHERE id=?")
//@Where(clause = "deleted = false") // deprecated
@SQLRestriction("status_record <> 'INACTIVE'")
public class VirtualAccount extends BaseEntity{

    @NotNull
    @ManyToOne @JoinColumn(name = "id_payment_provider")
    private PaymentProvider paymentProvider;

    @NotNull
    @ManyToOne @JoinColumn(name = "id_invoice_type")
    private Invoice invoice;

    @NotNull @NotEmpty @Size(min = 1)
    private String companyId;

    @NotNull @NotEmpty @Size(min = 1)
    private String accountNumber;

    @NotNull @Enumerated(EnumType.STRING)
    private VirtualAccountType virtualAccountType = VirtualAccountType.CLOSED;
}
