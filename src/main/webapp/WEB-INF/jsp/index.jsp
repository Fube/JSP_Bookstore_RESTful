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

        <h1 class="text-center mt-16 text-3xl">Welcome to the bookstore</h1>
        <h2 id="no-books" class="text-center mt-16 text-2xl">Nothing to display</h2>

        <table id="books" class="table table-dark mt-32" style="display:none;"/>

        <script id="books-template" type="text/x-handlebars-template">

            <table>
                <thead>
                    <tr>
                        <th scope="col">Author</th>
                        <th scope="col">Publisher</th>
                        <th scope="col">Publish Date</th>
                        <th scope="col">Edit</th>
                        <th scope="col">Delete</th>
                    </tr>
                </thead>
                <tbody>

                {{#each books}}
                    <tr>
                        <td>{{this.author}}</td>
                        <td>{{this.publisher}}</td>
                        <td>{{this.publishDate}}</td>
                        <td>
                            <a href="/editBook?id={{this.id}}&author={{this.author}}&publisher={{this.publisher}}&publishdate={{this.publishDate}}">Edit Book</a>
                        </td>
                        <td>
                            <a href="#" onclick="handleDelete('{{this.id}}')">Delete</a>
                        </td>
                    </tr>
                {{/each}}

                </tbody>
            </table>

        </script>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.3/handlebars.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/axios@0.21.0/dist/axios.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
        <script async defer>


            const source = document.querySelector`#books-template`.innerHTML;
            const template = Handlebars.compile(source);
            const books = document.querySelector`#books`;

            async function handleDelete(id){
                await axios({
                    method: 'DELETE',
                    url: '/bookstore/books',
                    data: { id }
                });

                await getBooks();
            }

            async function getBooks(){
                const { data } = await axios('/bookstore/books');

                books.innerHTML = template(
                    {
                        books: data.map(n =>  Object.assign(n, { publishDate: moment(n.publishDate).format("DD/MM/YYYY") } )),
                    }
                );

                books.style.display = data.length ? 'table' : 'none';
                document.querySelector`#no-books`.style.display = !data.length ? 'block' : 'none';
            }

            getBooks();
        </script>
    </body>
</html>