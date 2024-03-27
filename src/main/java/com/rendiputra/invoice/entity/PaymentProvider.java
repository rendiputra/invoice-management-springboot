package com.rendiputra.invoice.entity;

import jakarta.persistence.Entity;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Data;
import org.hibernate.annotations.SQLDelete;
import org.hibernate.annotations.SQLRestriction;

@Data @Entity
@SQLDelete(sql = "UPDATE payment_provider  SET status_record = 'INACTIVE' WHERE id=?")
//@Where(clause = "deleted = false") // deprecated
@SQLRestriction("status_record <> 'INACTIVE'")
public class PaymentProvider extends BaseEntity{
    @NotNull
    @NotEmpty
    @Size(min = 3, max = 100)
    private String code;

    @NotNull @NotEmpty @Size(min = 3, max = 100)
    private String name;

    private String logo;
}
