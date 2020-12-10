package com.nariman.bookstore.views;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class BookstoreController {

    @GetMapping(path = "/")
    public String index(){
        return "index";
    }

    @GetMapping(path = "/addBook")
    public String addBook(){
        return "addBook";
    }

    @GetMapping(path = "/editBook")
    public String editBook(){
        return "editBook";
    }

    @GetMapping(path = "/searchBook")
    public String searchBook(){
        return "searchBook";
    }
}
