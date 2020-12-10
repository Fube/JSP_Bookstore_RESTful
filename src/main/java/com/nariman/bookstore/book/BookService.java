package com.nariman.bookstore.book;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import javax.transaction.Transactional;
import java.util.List;

@Service
@Transactional
public class BookService {

    private final BookRepository bookRepository;

    @Autowired
    public BookService(BookRepository bookRepository) {
        this.bookRepository = bookRepository;
    }

    public List<Book> getAll() {
        return bookRepository.findAll();
    }

    public Book getOne(int id) {
        return bookRepository.findById(id).orElse(null);
    }

    public void save(Book book) {
        bookRepository.save(book);
    }

    public void update(Book book){

        if(getOne(book.getId()) == null)
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "entity not found");

        bookRepository.save(book);
    }

    public void delete(int id) {

        if(getOne(id) == null)
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "entity not found");

        bookRepository.deleteById(id);
    }

    public List<Book> findBookByAny(String query) {

        return bookRepository.findBookByAny(query);
    }
}
