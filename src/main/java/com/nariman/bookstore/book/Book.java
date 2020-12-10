package com.nariman.bookstore.book;

import lombok.Data;
import org.springframework.lang.NonNull;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Data
@Table(name = "BOOKS")
public class Book {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @NonNull
    private String author;

    private String publisher;

    private LocalDateTime publishDate;

}
