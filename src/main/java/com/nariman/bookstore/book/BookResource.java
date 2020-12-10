package com.nariman.bookstore.book;

import lombok.NonNull;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.Collections;
import java.util.List;

@RestController
@RequestMapping(path = "/bookstore/books")
public class BookResource {

    private final BookService bookService;

    @Autowired
    public BookResource(BookService bookService) {
        this.bookService = bookService;
    }

    @GetMapping
    public List<Book> getAll(){
        return bookService.getAll();
    }

    @GetMapping(path="/{id}")
    public Book getBook(@PathVariable int id){
        return bookService.getOne(id);
    }

    @PostMapping
    public ResponseEntity createBook(@RequestBody @NonNull @Validated Book book){

        if(book.getAuthor() == null || book.getPublisher() == null || book.getPublishDate() == null)
            return ResponseEntity.badRequest().body("Bad request");

        bookService.save(book);
        return ResponseEntity.ok().body("Ok");
    }

    @PutMapping
    public ResponseEntity updateBook(@RequestBody Book book){
        bookService.update(book);
        return ResponseEntity.ok().body("Ok");
    }

    @DeleteMapping
    public ResponseEntity deleteBook(@RequestBody Book book){
        bookService.delete(book.getId());
        return ResponseEntity.ok().body("Ok");
    }

    @GetMapping(path = "/query")
    @ResponseBody
    public List<Book> queryBooks(@RequestParam("query") @NonNull String query){

        try{
            int id = Integer.parseInt(query);
            return Collections.singletonList(bookService.getOne(id));
        }catch(final NumberFormatException ex){
            return bookService.findBookByAny(query);
        }
    }

}
