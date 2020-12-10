<%@ page language="java" contentType="text/html; ISO-8859-1"
         pageEncoding="ISO-8859-1" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="ISO-8859-1">
        <title>Bookstore</title>
        <link rel="stylesheet"  href="/css/index.css">
        <link rel="stylesheet"
              href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
              integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z"
              crossorigin="anonymous"
        >
        <link href="https://unpkg.com/tailwindcss@^2/dist/tailwind.min.css" rel="stylesheet">
    </head>


    <body class="container">

        <ul class="nav flex justify-center pt-8">
            <li class="nav-item">
                <a class="nav-link active" href="/">View Books</a>
            </li>

            <li class="nav-item">
                <a class="nav-link" href="/addBook">Add Book</a>
            </li>

            <li class="nav-item">
                <a class="nav-link" href="/searchBook">Search Books</a>
            </li>
        </ul>


        <h1 class="text-center mt-16 text-3xl">Edit a book</h1>

        <form class="text-center mt-32" onsubmit="handleEdit();return false;">

            <div class="flex justify-center">
                <div class="form-group">
                    <label class="text-left w-full" for="author">Author</label>
                    <input type="text" class="form-control w-72" id="author" placeholder="Enter author">
                </div>
            </div>

            <div class="flex justify-center">
                <div class="form-group">
                    <label class="text-left w-full" for="publisher">Publisher</label>
                    <input type="text" class="form-control w-72" id="publisher" placeholder="Enter publisher">
                </div>
            </div>

            <div class="flex justify-center">
                <div class="form-group">
                    <label class="text-left w-full" for="publish-date">Publish date</label>
                    <input type="text" class="form-control w-72" id="publish-date" placeholder="Enter publish date DD/MM/YYYY">
                </div>
            </div>


            <button type="submit" class="btn btn-primary mt-24">Submit</button>
        </form>

        <script async src="https://cdn.jsdelivr.net/npm/axios@0.21.0/dist/axios.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
        <script async defer>

            const urlParams = new URLSearchParams(location.search);

            document.querySelector`#author`.value = urlParams.get('author');
            document.querySelector`#publisher`.value = urlParams.get('publisher');
            document.querySelector`#publish-date`.value = moment(urlParams.get('publishdate'), 'DD/MM/YYYY').format('DD/MM/YYYY');

            async function handleEdit() {

                const [
                    author,
                    publisher,
                    publishDate
                ] = [...document.querySelectorAll`form input`].map(n => n.value);

                const momentized = moment(publishDate, 'DD/MM/YYYY');


                if(! (author && author.length)){
                    alert("Invalid author name");
                    return;
                }

                if(! (publisher && publisher.length)){
                    alert("Invalid publisher");
                    return;
                }

                if(momentized.toString().toLowerCase() === 'invalid date'){
                    alert("Invalid publish date format");
                    return;
                }

                const body = {

                    id: urlParams.get('id'),
                    author,
                    publisher,
                    publishDate: momentized.toDate(),
                };

                await axios({
                    method: 'PUT',
                    url: `/bookstore/books`,
                    data: body,
                });

                window.location.replace(window.location.origin);
            }
        </script>
    </body>
</html>