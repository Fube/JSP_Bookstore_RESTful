# Bookstore

## How to run

Go to build -> libs <br>
Open a shell instance <br>
Run `java -jar bookstore.war`<br>
You can also add ` --spring.datasource.url=jdbc:h2:file:~/data/bookstore` on Mac to make the database persistent <br>
By default, it will run on memory so on restart, all data will be lost <br>
