package com.example.Model;

import lombok.Getter;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "users")
@Getter
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer userId;

    private String displayName;
    private Integer reputation;
    private String profileImage;

    @Temporal(TemporalType.TIMESTAMP)
    private Date creationDate;

    private String badgeCounts;

}
