# Table of Contents
<!-- TOC depthFrom:1 depthTo:6 withLinks:1 updateOnSave:1 orderedList:0 -->

- [Table of Contents](#table-of-contents)
	- [Chapter 1 Introduction](#chapter-1-introduction)
	- [Chapter 2 Setting up environment](#chapter-2-setting-up-environment)
	- [Chapter 3 Introduction to PHP](#chapter-3-introduction-to-php)
	- [Chapter 4 Expressions and Control Flow](#chapter-4-expressions-and-control-flow)
	- [Chapter 5 Functions and Objects](#chapter-5-functions-and-objects)
	- [Chapter 6 Arrays](#chapter-6-arrays)
	- [Chapter 7 Practical PHP](#chapter-7-practical-php)
	- [Chapter 8 Introduction to MySQL](#chapter-8-introduction-to-mysql)
	- [Chapter 9 Mastering MySQL](#chapter-9-mastering-mysql)
	- [Chapter 10 Access MySQL using PHP](#chapter-10-access-mysql-using-php)
	- [Chapter 11 Form Handling](#chapter-11-form-handling)
	- [Chapter 12 Cookies, Sessions, and Authentications](#chapter-12-cookies-sessions-and-authentications)
	- [Chapter 13 Exloring Javascript](#chapter-13-exloring-javascript)
	- [Miscellaneous](#miscellaneous)
		- [REST](#rest)

<!-- /TOC -->

## Chapter 1 Introduction
![image](./general%20flowchart.png)

**PHP**: for backend use. Achieve dynamic webpage by generating html specific to user request.

**MySQL**: relational database

**Javascript**: Front-end. Embedded in html. Computation happens on the front-end browser, change the webpage dynamically.

**CSS**: Cascading Style Sheet. Layout the webpage

**HTML5**: Basic component of a webpage.

## Chapter 2 Setting up environment

XAMPP is a bundle of Apache(web server), PHP, MariaDB(a fork of MySQL)

After installation, start xampp and check if we can access http://localhost
from browser. The root document folder (`localhost/`) is in `xampp/htdocs`

## Chapter 3 Introduction to PHP
```php
<?php
    echo "Hello"."World!";
?>
```

PHP use . to link strings together.

Escape characters only works in double-quote("") strings. In single quote strings, only \\' and \\\ could be recognized.

PHP also offers a multiline sequence using the <<< operator—commonly referred to as a here-document or heredoc:
```php
<?php
echo <<<_END
Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it.

- $author.
_END;
?>
```

**Constants**:
```php
define("ROOT_LOCATION", "/usr/local/www/");
```

Predefined constants : *\_\_FILE__* ...

**Functions**:
```php
<?php
function longdate($timestamp)
{
return date("l F jS Y", $timestamp);
}
?>
```

**Variables**:  
variables are always prefixed with $. So compiler can accelerate the compiling.  
variables created outside of any functions can be accessed only by
nonfunction code.

```php
global $is_logged_in; //global variable definition
static $count = 0; //defined in function, retain value after function exits
```
It is illegal to assign static variables with initial values from **expressions** or **function calls**

There are superglobal variables, e.g. **$_SERVER**.  
**Caution**: Hackers often load up *$_GET, $_POST* with malicious code such as SQL command. So remember always sanitize superglobal variables before use.

Using the ++**htmlentities**++ function for sanitization is an important practice in any circumstance where user or other third-party data is being processed for output, not just with superglobals.

----
## Chapter 4 Expressions and Control Flow

PHP define TRUE as 1, FALSE as NULL.

=== and !== are the identity operators. It prevents PHP from automatically converting types.

***break 2*** can break out of 2 layers of loop.

Control flows are same as C/C++.
```php
if elseif else;
switch case break;
for, while loop;
```

---
## Chapter 5 Functions and Objects

The ***phpinfo*** function is extremely useful for obtaining informa‐
tion about your current PHP installation, but that information
could also be very useful to potential hackers. Therefore, never
leave a call to this function in any web-ready code.

**Function**:
```php
function function_name([parameter [, ...]])
{
// Statements
}
```
Function names are **case-insensitive**

To create an array:
```php
array(n1, n2 ,n3, ...) //returns an array of n1, n2, n3...
```

Include:
```php
//may produce multiple inclusion
include "library.php"
//recommended, but only attempt to include the file
include_once "library.php"
//require the file must exist
require_once "library.php"
```
It is always recommended to use ***require_once***.

***function_exists()*** check if a function is defined.

**Class**

class name is case-sensitive. A class example:
```php
<?php
$object = new User;
print_r($object); echo "<br>";//print object in human-readable form
$object->name = "Joe";
$object->password = "mypass";
print_r($object); echo "<br>";
$object->save_user();
class User
{
    public $name, $password;
    function save_user()
    {
        echo "Save User code goes here";
    }
}
?>
```
the expression $object->$property would attempt to look up the value assigned to a variable named $property (let’s say that value is the string brown ) and then attempt to reference the property $object->brown . If $property is undefined, an attempt to reference $object->NULL would occur and cause an error.

In PHP it is considered a good practice to **put function and object definitions to the end of the file**.

Object variables are **references** in PHP.

***clone*** create a new instance:
```php
$object2 = clone $object1;
```

Constructors:
```php
<?php
class User
{
    function User($param1, $param2 ...);
    or
    function __construct($param1, $param2 ...)
    {
        public $username = "Guest";
        ...
    }
}
?>
```

use static method:
```php
User::pwd_password();
```

Define a property implicitly(not recommended)
```php
<?php
$object1 = new User();
$object1->name = "Alice";
echo $object1->name;
class User {}
?>
```

Declaring Constants:
```php
<?php
Translate::lookup();
class Translate
{
    const ENGLISH = 0;
    const SPANISH = 1;
    const FRENCH = 2;
    const GERMAN = 3;
    //...
    static function lookup()
    {
        echo self::SPANISH;//self indicates the class name
    }
}
?>
```

***parent::method()*** calls the method defined in parent.
***parent::__construct()*** calls the constructor of parent;

---
## Chapter 6 Arrays

Add items to an array:
```php
<?php
$paper[] = "Copier";
$paper[] = "Inkjet";
$paper[] = "Laser";
$paper[] = "Photo";

print_r($paper);
?>
```

Associative Array:
```php
<?php
$paper['copier'] = "Copier & Multipurpose";
$paper['inkjet'] = "Inkjet Printer";
$paper['laser'] = "Laser Printer";
$paper['photo'] = "Photographic Paper";

echo $paper['laser'];
?>
```

Use the ***array()*** keyword and ***foreach ... as*** loop:
```php
<?php
$paper = array("Copier", "Inkjet", "Laser", "Photo");
$j = 0;
foreach($paper as $item)
{
    echo "$j: $item<br>";
    ++$j;
}

$paper = array('copier' => "Copier & Multipurpose",
            'inkjet' => "Inkjet Printer",
            'laser'  => "Laser Printer",
            'photo'  => "Photographic Paper");
foreach($paper as $item => $description)
    echo "$item: $description<br>";
//an alternative to foreach ... as
while (list($item, $description) = each($paper))
    echo "$item: $description<br>";
?>
```
***each*** returns *FALSE* when there is no more pairs to return.
The ***list*** function takes an array as its argument (in this case, the key/value pair returned by the function ***each*** and then assigns the values of the array to the variables listed within parentheses.

**Array functions**:
- ***is_array($a)*** : check if *a* is an array
- ***count($a, 1)*** : return the number of elements in *a*
  - 0 indicates only count top level, 1 indicates count recursively
- ***sort($a, SORT_NUMERIC), rsort($a)***: sort or reversely sort an array
  -  returns TRUE on success, FALSE on error
- ***explode(" ", "This is a sentence")***: split the string
- ***extract($_GET, EXTR_PREFIX_ALL, 'fromget')***
  - Extract from associative array *_GET*, for each key-value pair(e.g. k-v) create a variable named *fromget_k* with value *v*.
- ***compact(varname1, varname2, ...)***: the opposite of extract
  - use *compact* to debug:
```php
<?php
        $j = 23;
        $temp = "Hello";
        $address = "1 Old Street";
        $age = 61;

        print_r(compact(explode(' ', 'j temp address age')));
?>
```
- ***reset($a)***: reset the iterator in *foreach* or *each*
- ***end($a)***: move the iterator to the end

## Chapter 7 Practical PHP

**printf, sprintf**

Date and Time:
- ***time()*** : return current time since Jan.1 1970 in seconds
- ***mktime(hour, minute, second, month, day, year)***: timestamp
- ***date($format, $timestamp)*** : display date in special format
- ***checkdate($month, $day, $year)***: check validity

File Handling:

- ***file_exists(filename)***: check if the file exists
- ***$fp = fopen(filename, "w")***: create a file to write to
- ***fwrite($fp, "text")***: write to fp
- ***fread($fp, num)***: read *num* characters and return
- ***fgets($fp)***: read a line and return
- ***fclose($fp)***: close the file
- ***die(text)***: abort the program and give *text* as error message
- ***copy(src_filename, dst_filename)***: copy the file
- ***rename(src, dst)***: move the file
- ***unlink(filename)***: remove the file
- ***fseek(fp, offset, SEEK_END)***: seek to the end of the file
- ***flock(fp, LOCK_TYPE)***: lock the file to prevent simultaneous access
    - *advisory* lock: only locks out other processes calling *flock*
- ***file_get_contents(filename)***: read entire file
    - *echo file_get_contents("http://oreilly.com")*;

Upload file:
```php
<?php // upload.php
echo <<<_END
    <html><head><title>PHP Form Upload</title></head><body>
    <form method='post' action='upload.php'     enctype='multipart/form-data'>
    Select File: <input type='file' name='filename' size='10'>
    <input type='submit' value='Upload'>
</form>
_END;
if ($_FILES)
{
    $name = $_FILES['filename']['name'];
    move_uploaded_file($_FILES['filename']['tmp_name'], $name);
    echo "Uploaded image '$name'<br><img src='$name'>";
}
echo "</body></html>";
?>
```

sanitize a file name:
```php
$name = preg_replace("/[^A-Za-z0-9.]/", "", $name);//only alphanumeric allowed
```

Execute a system command:
```php
<?php // exec.php
$cmd = "dir"; // Windows
// $cmd = "ls"; // Linux, Unix & Mac
exec(escapeshellcmd($cmd), $output, $status);
if ($status) echo "Exec command failed";
else
{
    echo "<pre>";
    foreach($output as $line)
        echo htmlspecialchars("$line\n");
    echo "</pre>";
}
?>
```
function ***htmlspecialchars*** turn any special characters into the way html understands.

**Other useful functions**

- ***json_encode(array)*** accepts an associative array and turns it into a json string.
- ***implode(glue, pieces)*** join array with *glue* into a string.
- ***in_array(element, array)*** test if *element* is in *array*.
- ***usort(array, function($a, $b){//definition})*** sort
- ***parse_str(str, arr)***: parse *str* as http query string and generate
	key-value pairs into associative array *arr*


## Chapter 8 Introduction to MySQL

MySQL CLI(Command Line Interface):

Use **\c**, not Ctrl+C to stop the current command.

```sql
SHOW DATABASES;
CREATE DATABASE publications;
USE publications;
```

Reset root password and create new user:
```sql
mysql -u root -p
USE mysql;
SET PASSWORD FOR 'root'@'localhost' = PASSWORD('MyNewPass');
CREATE USER 'newuser'@'localhost' IDENTIFIED BY 'password';
```

Grant Priviledges to a user:
```sql
GRANT PRIVILEGES ON database.object TO 'username'@'hostname' IDENTIFIED by 'pass';
GRANT ALL ON *.* TO 'jim'@'localhost' IDENTIFIED BY 'password';
```

Create Table:
```sql
CREATE TABLE classics (
author VARCHAR(128),
title VARCHAR(128),
type VARCHAR(16),
year CHAR(4)) ENGINE MyISAM;
```

Describe all columns of a table:
```sql
DESCRIBE classics;
```

Common data types:
- ***CHAR(n) n<=255***: fixed size character string
- ***VARCHAR(n) n<=65535***: variable size character string
- ***BINARY(n) or BYTE(n) n<=255***: storing full bytes, e.g. GIF images
- ***VARBINARY(n) n<=65535***: variable binary
- ***TINYTEXT(n), TEXT(n), MEDIUMTEXT(n), LONGTEXT(n)***:
    - TEXT field cannot have default values
    - VARCHAR is better and faster if you need to search full content
    - sizes: 255, 65535, 1.67e+7, 4.29e+9
- ***TINYBLOB(n), BLOB(n), MEDIUMBLOB(n), LONGBLOBG(n)***:Binary Large OBject
    - same as TEXT
- ***TINYINT, SMALLINT, MEDIUMINT, INT/INTEGER, BIGINT, FLOAT, DOUBLE/REAL***: Numeric data types
    - bytes used: 1, 2, 3, 4, 8, 4, 8

Code sample:
```sql
CREATE TABLE tablename (fieldname INT UNSIGNED); /*unsigned int*/
CREATE TABLE tablename (fieldname INT(4) ZEROFILL);
    /*the display width of the integer is 4, fill spaces with 0. (e.g. 0022, 0001)*/
```
- ***DATETIME, DATE, TIMESTAMP, TIME, YEAR***
    - MySQL can automatically set the value of a TIMESTAMP

Add a auto-increment column "id":
```sql
ALTER TABLE classics ADD id INT UNSIGNED NOT NULL AUTO_INCREMENT KEY;
```

Insert new rows:
```sql
INSERT INTO classics(author, title, type, year)
VALUES('Mark Twain','The Adventures of Tom Sawyer','Fiction','1876');

INSERT INTO customers(name,isbn) VALUES/*batch insert*/
('Joe Bloggs','9780099533474'),
('Mary Smith','9780582506206'),
('Jack Wilson','9780517123201');
```

Rename table, change column, delete table:
```sql
ALTER TABLE classics RENAME pre1900;/*rename table*/
ALTER TABLE classics MODIFY year SMALLINT;/*change column data type*/
ALTER TABLE classics ADD pages SMALLINT UNSIGNED;/*add column*/
ALTER TABLE classics CHANGE type category VARCHAR(16);/*rename column*/
ALTER TABLE classics DROP pages;/*delete column*/
DROP TABLE disposable;/*delete table*/
```

Add Index(to be used as keys to facilitate query):
```sql
ALTER TABLE classics ADD INDEX(title(20));/*use first 20 chars as index*/
CREATE INDEX author ON classics (author(20));/*equivalent*/
```
The column's KEY property is *MUL*, which means there might be multiple ocurrences of the same value in that column.

Create table with indices and primary key:
```sql
CREATE TABLE classics (
author VARCHAR(128),
INDEX(author(20))
PRIMARY KEY(isbn)
) ENGINE MyISAM;
```

Add primary key:
```sql
ALTER TABLE classics ADD isbn CHAR(13);
[code to insert data]
ALTER TABLE classics ADD PRIMARY KEY(isbn);
```

Add ***FULLTEXT*** index:
```sql
ALTER TABLE classics ADD FULLTEXT(author, title);
```
- FULLTEXT use every word in TEXT, VARCHAR or CHAR as index
- Only available on MyISAM engine;
- Faster to **first** load data, then add FULLTEXT index

**NOTE : tweak index to increase DB performance**

**SQL query Commands**
```sql
SELECT * FROM classics; /*Display all columns*/
SELECT author, title FROM classics; /* display author, title*/
SELECT COUNT(*) FROM classics; /*number of rows*/
SELECT DISTINCT author FROM classics;
    /*eliminate duplicate authors*/
DELETE FROM classics WHERE title='Little Dorrit';
SELECT author,title FROM classics WHERE title LIKE "%and%";
    /*wildcard % match any string, including empty string*/
SELECT author,title FROM classics LIMIT 3,1;
    /*Skip 3 rows, display 1 row*/
SELECT author, title FROM classics WHERE MATCH(author, title) AGAINGST('curiosity');
    /*Search any row whose (author, title) contains 'curiosity'*/
    /*Apply on FULLTEXT field; don't use common word e.g.(am, is, and ...)*/
SELECT author,title FROM classics
    WHERE MATCH(author,title)
    AGAINST('+charles -species "origin of"' IN BOOLEAN MODE);
    /* Boolean Mode: indicate which word should present and which not*/
    /*+: must present; -: must not present; no sign: present or not*/
    /*"origin of" must present together*/
UPDATE classics SET category='Classic Fiction' WHERE category='Fiction';
SELECT author,title,year FROM classics ORDER BY author,year DESC;
    /*sort by author ascendingly, then year descendingly*/
SELECT category,COUNT(author) FROM classics GROUP BY category;
```

Joining tables:
```sql
SELECT name,author,title from customers,classics
    WHERE customers.isbn=classics.isbn;
SELECT name,author,title FROM customers
    JOIN classics ON customers.isbn=classics.isbn;
SELECT name,author,title FROM customers NATURAL JOIN classics;
    /*natural join, automatically join columns that have the same name*/
SELECT name,author,title FROM
    customers AS cust, classics AS class WHERE cust.isbn=class.isbn;
```

***AND, OR,*** and ***NOT*** can be used in WHERE conditions.

MySQL use `#` to represent the start of comment.

## Chapter 9 Mastering MySQL

**Normalization** : Reduce Duplication
-   Duplicate makes database larger
-   When updating, duplicate tends to produce inconsistency(multiple records to update)
-   Normally 2NF is sufficient

- **First Normal Form**:
    - There should be no repeating columns containing the same kind     of data;
    - All columns should contain a single value;
    - There should be a primary key to uniquely identify each row

- **Second Normal Form**: Identify column whose data repeats across different places, then remove them into a single table

- **Third Normal Form**: Column that is not directly dependant on primary key but dependant on another value should be moved to a single table

- **Drawback of normalization**: Normalization will spread data into different tables, this requires multiple calls to MySQL for each query, thus slowing the performance down.

**Relationships**
- One to one: simply include them in a single table
- One to many: In the "many" table, add a column with the primary key of "one" table as foreign key to indicate their relationship
- Many to many: Add a third table containing each table's primary key. This table solely serve for the purpose of the relationship

**Transactions**

Transactions are atomic series of queries or updates

Transaction Storage Engine: InnoDB
```sql
CREATE TABLE accounts (
number INT, balance FLOAT, PRIMARY KEY(number)
) ENGINE InnoDB;
```

Transactions in MySQL starts with **BEGIN** or **START TRANSACTIONS** command, ends with **COMMIT** or **ROLLBACK** commands.
```sql
BEGIN;
UPDATE accounts SET balance=balance-250 WHERE number=12345;
UPDATE accounts SET balance=balance+250 WHERE number=67890;
SELECT * FROM accounts; /*data being updated*/
ROLLBACK;
SELECT * FROM accounts; /*data rolled back to previous values*/
```

Using **EXPLAIN** command with a following query, we can check how MySQL interpret it. It can be helpful if we want to optimize the query.

**Backing up and Restoring**

```
mysqldump -u username -p databasename > mysqlbackup.sql
```

Shutdown mysql server before backup; Or to lock the tables:
```sql
LOCK TABLES tablename1 READ, tablename2 READ ... /* only allowing read*/
UNLOCK TABLES; /*after backup*/
```

To restore
```
mysql -u username -p -D databasename < mysqlbackup.sql
```

OAuth Table:
```sql
CREATE TABLE `users` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `oauth_provider` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `oauth_uid` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `fname` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `lname` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
    `gender` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
    `locale` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
    `picture` text  COLLATE utf8_unicode_ci NOT NULL,
    `created` datetime NOT NULL,
    `modified` datetime NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
```

## Chapter 10 Access MySQL using PHP

Create login.php file in document root folder:
```php
<?php
    $hn = 'localhost';
    $db = 'publications';
    $un = 'username';
    $pw = 'passowrd';
?>
```

Connect and Send a query to mysql server:
```php
<?php // query.php
    require_once 'login.php';
    $conn = new mysqli($hn, $un, $pw, $db);
    if ($conn->connect_error) die($conn->connect_error);
    $query = "SELECT * FROM classics";
    $result = $conn->query($query);
    if (!$result) die($conn->error);
    $rows = $result->num_rows;
    for ($j = 0 ; $j < $rows ; ++$j)
    {
        $result->data_seek($j);
        echo 'Author: ' . $result->fetch_assoc()['author'] . '<br>';
        $result->data_seek($j);
        echo 'Title: ' . $result->fetch_assoc()['title'] . '<br>';
        $result->data_seek($j);
        echo 'Category: ' . $result->fetch_assoc()['category'] . '<br>';
        $result->data_seek($j);
        echo 'Year: ' . $result->fetch_assoc()['year'] . '<br>';
        $result->data_seek($j);
        echo 'ISBN: ' . $result->fetch_assoc()['isbn'] . '<br><br>';
    }
    $result->close();
    $conn->close();
?>
```

No need to put semicolon; after SQL query for PHP

Fetch one row at a time:
```php
<?php
  for ($j = 0 ; $j < $rows ; ++$j)
  {
    $result->data_seek($j);
	$row = $result->fetch_array(MYSQLI_ASSOC);

    echo 'Author: '   . $row['author']   . '<br>';
    echo 'Title: '    . $row['title']    . '<br>';
    echo 'Category: ' . $row['category'] . '<br>';
    echo 'Year: '     . $row['year']     . '<br>';
    echo 'ISBN: '     . $row['isbn']     . '<br><br>';
  }
 ?>
```

Form handling example: pg 240
```php
<?php // sqltest.php
require_once 'login.php';
$conn = new mysqli($hn, $un, $pw, $db);
if ($conn->connect_error) die($conn->connect_error);

if (isset($_POST['delete']) && isset($_POST['isbn']))//delete record
{
    $isbn = get_post($conn, 'isbn');
    $query = "DELETE FROM classics WHERE isbn='$isbn'";
    $result = $conn->query($query);
    if (!$result) echo "DELETE failed: $query<br>" .
        $conn->error . "<br><br>";
}
if (isset($_POST['author']) && isset($_POST['title']) && isset($_POST['category']) &&
    isset($_POST['year']) && isset($_POST['isbn']))//insert record
{
    $author = get_post($conn, 'author');
    $title = get_post($conn, 'title');
    $category = get_post($conn, 'category');
    $year = get_post($conn, 'year');
    $isbn = get_post($conn, 'isbn');
    $query = "INSERT INTO classics VALUES" .
        "('$author', '$title', '$category', '$year', '$isbn')";
    $result = $conn->query($query);
    if (!$result) echo "INSERT failed: $query<br>" .
        $conn->error . "<br><br>";
}
/* print form for new record insertion*/
echo <<<_END
    <form action="sqltest.php" method="post"><pre>
    Author <input type="text" name="author">
    Title <input type="text" name="title">
    Category <input type="text" name="category">
    Year <input type="text" name="year">
    ISBN <input type="text" name="isbn">
    <input type="submit" value="ADD RECORD">
    </pre></form>
_END;

$query = "SELECT * FROM classics";
$result = $conn->query($query);
if (!$result) die ("Database access failed: " . $conn->error);

$rows = $result->num_rows;
for ($j = 0 ; $j < $rows ; ++$j) //print every row, display button for deletion
{
    $result->data_seek($j);
    $row = $result->fetch_array(MYSQLI_NUM);
    echo <<<_END
        <pre>
        Author $row[0]
        Title $row[1]
        Category $row[2]
        Year $row[3]
        ISBN $row[4]
        </pre>
        <form action="sqltest.php" method="post">
        <input type="hidden" name="delete" value="yes">
        <input type="hidden" name="isbn" value="$row[4]">
        <input type="submit" value="DELETE RECORD"></form>
    _END;
}

$result->close();
$conn->close();
function get_post($conn, $var)
{
    return $conn->real_escape_string($_POST[$var]);
}
?>
```

`mysql_real_escape_string` or `conn->real_escape_string` strips out any
characters that a hacker may have inserted.

HTTP request: GET vs POST
- GET: data are sent through URL, only ASCII letters  
- POST: data is sent in HTTP message body, no restrictions are data type.

Table in HTML:
```html
    <table>
        <tr> <th>head1</th> <th>head2</th> ... </tr>
        <tr> <td>desc1</td> <td>desc2</td> ... </tr>
        ...
    </table>        
```

Display the auto-increment id(The first value of a row is an auto_increment field)
```php
<?php
$query = "INSERT INTO cats VALUES(NULL, 'Lynx', 'Stumpy', 5)";
$result = $conn->query($query);
if (!$result) die ("Database access failed: " . $conn->error);
echo "The Insert ID was: " . $result->insert_id;
?>
```

**Security**

**SQL Injection**
```php
<?php
$user = $_POST['user']; //$user == "anything' OR 1=1 #"
$pass = $_POST['pass'];
$query = "DELETE FROM users WHERE user='$user' AND pass='$pass'";
/* DELETE FROM users WHERE user='anything' OR 1=1 #' AND pass=''*/
?>
```

Always use `conn->real_escape_string()` to sanitize the input string; or use
MySQL placeholders:
```sql
PREPARE statement FROM "INSERT INTO classics VALUES(?,?,?,?,?)";
SET @author = "Emily Brontë",
	@title = "Wuthering Heights",
	@category = "Classic Fiction",
	@year = "1847",
	@isbn = "9780553212587";
EXECUTE statement USING @author,@title,@category,@year,@isbn;
DEALLOCATE PREPARE statement;
```
In php, to use place holders:
```php
<?php
$stmt = $conn->prepare('INSERT INTO classics VALUES(?,?,?,?,?)');
$stmt->bind_param('sssss', $author, $title, $category, $year, $isbn);
/* s stands for string; i: integer; d: double; b: blob*/
$stmt->execute();
printf("%d Row inserted.\n", $stmt->affected_rows);
$stmt->close();
$conn->close();
?>
```

**HTML Injection**

Hacker could leave such a comment in user's page:
```html
<script src='http://x.com/hack.js'>
</script><script>hack();</script>
```
After using `htmlentities()`:
```
&lt;script src='http://x.com/hack.js'&gt; &lt;/script&gt;
&lt;script&gt;hack();&lt;/script&gt;
```
## Chapter 11 Form Handling

An example of `<form>`
```php
<html>
    <head>
        <title>Form test</title>
    </head>
    <body>
        <form method="post" action="formtest.php">
            <!--
                default value of "name" is "yang", default value can also
                be used for hidden fields to pass values
            -->
            <input type="text" name="name" value="yang">
            <input type="submit">
        </form>
    </body>
</html>
```

`$_POST` is an associative array which stores data submitted in `<form>`

If `register_global` is set, it indicates instead of `_POST['name']`, `$name`
is preloaded with value when PHP starts. This is **not recommended**.

**Form Types:**

```html
<!-- Text Box.
    size indicates the width of textbox(in the number of chars)
    maxlength is the maximum number of chars that is allowed to enter-->
<input type="text" name="name" size="size" maxlength="length" value="value">
<!-- Text area has its own tag.
    "wrap" field can have three values: off, soft, hard-->
<textarea name="name" cols="width" rows="height" wrap="soft">
    This is some default text.
</textarea>
<!-- Check Box. The "value" field will be "on" if omitted. value will be submitted-->
<input type="checkbox" name="name" value="value" checked="checked">
<!-- Submitting multiple values, _POST['ice'] will be an array of strings-->
Vanilla <input type="checkbox" name="ice[]" value="Vanilla">
Chocolate <input type="checkbox" name="ice[]" value="Chocolate">
Strawberry <input type="checkbox" name="ice[]" value="Strawberry">
<!-- Radio Buttons -->
8am-Noon<input type="radio" name="time" value="1">
Noon-4pm<input type="radio" name="time" value="2" checked="checked">
4pm-8pm<input type="radio" name="time" value="3">
<!-- hidden input -->
<input type="hidden" name="hiddeninput" value="yes">
<!-- Dropdown Menu, "size" indicates number of items to display,
    multiple indicates multiple items could be selected-->
<select name="name" size="size" multiple="multiple">
Vegetable:    
<select name="veg" size="1">
    <option value="Peas">Peas</option>
    <option selected="selected" value="Beans">Beans</option>
    <option value="Carrots">Carrots</option>
</select>
<!-- Label, click anywhere in the label to select the radio button -->
<label>8am-Noon<input type="radio" name="time" value="1"></label>
<!-- submit button -->
<input type="submit" value="Search">
<!-- click image to submit -->
<input type="image" name="submit" src="image.gif">
```
Note: hidden fields are **not secure**. Every body could view source.

Universal Sanitizing:
```php
<?php
  function sanitizeString($var)
  {
    if (get_magic_quotes_gpc())
      $var = stripslashes($var);
    $var = strip_tags($var);
    $var = htmlentities($var);
    return $var;
  }

  function sanitizeMySQL($connection, $var)
  {
    $var = $connection->real_escape_string($var);
    $var = sanitizeString($var);
    return $var;
  }
?>
```
New in html5:
```html
<!-- Autocomplete -->
<form action='myform.php' method='post' autocomplete='on'>
    <input type='text' name='username'>
    <input type='password' name='password' autocomplete='off'>
</form>
<!-- Auto focus -->
<input type='text' name='query' autofocus='autofocus'>
<!-- Placeholder attribute, give a hint in text box -->
<input type='text' name='name' size='50' placeholder='First & Last name'>
<!-- Required attribute: ensure a field has been completed before submission-->
<input type='text' name='creditcard' required='required'>
<!-- Overide attributes, for example 'formaction' -->
<form action='url1.php' method='post'>
    <input type='text' name='field'>
    <input type='submit' formaction='url2.php'>
</form>
<!-- width and height attributes -->
<input type='image' src='picture.png' width='120' height='80'>

<!-- form attribute, input doesn't have to be in <form> -->
<form action='myscript.php' method='post' id='form1'>
</form>
<input type='text' name='username' form='form1'>
<!-- The list attribute -->
Select destination:
<input type='url' name='site' list='links'>
<datalist id='links'>
	<option label='Google' value = 'http://google.com'>
	<option label='Yahoo!' value = 'http://yahoo.com'>
	<option label='Bing' value = 'http://bing.com'>
	<option label='Ask' value = 'http://ask.com'>
</datalist>
<!-- min and max, and step attribute -->
<input type='time' name='meeting' value='12:00' min='09:00' max='16:00' step='3600'>
<!-- color picker -->
Choose a color <input type='color' name='color'>
<!-- number and range input type -->
<input type='number' name='age'>
<input type='range' name='num' min='0' max='100' value='50' step='1'>
<!-- date and time picker: date, month, week, time, datetime ...-->
<input type='time' name='time' value='12:34'>
```

## Chapter 12 Cookies, Sessions, and Authentications
![image](./cookie%20flowchart.png)

Use cookie in PHP: (pg 289)
```php
<?php
if (isset($_COOKIE['username'])) $username = $_COOKIE['username'];//access cookie
setcookie(name, value, expire, path, domain, secure, httponly);//set a cookie
?>
```
To destroy a cookie, issue a cookie with expiration date in the past.

**HTTP Authentication**: pg 291
```php
<?php
if (isset($_SERVER['PHP_AUTH_USER']) && isset($_SERVER['PHP_AUTH_PW']))
{
	echo "Welcome User: " . $_SERVER['PHP_AUTH_USER'] .
		" Password: " . $_SERVER['PHP_AUTH_PW'];
}
else
{
	header('WWW-Authenticate: Basic realm="Restricted Section"');
	header('HTTP/1.0 401 Unauthorized');
	die("Please enter your username and password");
}
?>
```
Once authenticated, the browser will keep sending the same username and password
until the browser exits.

**Storing username and passwords**

```php
$saltedPassword = "salt".$mypassword."string";
$token = hash('ripemd128', $saltedPassword);
```

**Sessions**

place a cookie in user's browser to uniquely identify the user,
then use groups of variable stored on the server that are only related to
this user to track down the user. (If user disable cookie, PHP simply put
a field in GET request)

```php
<?php
//authenticate.php
session_start();
$_SESSION['username'] = $un_temp;
$_SESSION['password'] = $pw_temp;
$_SESSION['forename'] = $row[0];
$_SESSION['surname'] = $row[1];
echo "$row[0] $row[1] : Hi $row[0], you are now logged in as '$row[2]'";
die ("<p><a href=continue.php>Click here to continue</a></p>");
//continue.php
session_start();
if (isset($_SESSION['username']))
{
	$username = $_SESSION['username'];
	$password = $_SESSION['password'];
	$forename = $_SESSION['forename'];
	$surname = $_SESSION['surname'];
	echo "Welcome back $forename.<br> Your full name is $forename $surname.<br>
		Your username is '$username' and your password is '$password'.";
}
else echo "Please <a href='authenticate.php'>click here</a> to log in.";
?>
```
To destroy a session:
```php
<?php
function destroy_session_and_data()
{
	$_SESSION = array();
	setcookie(session_name(), '', time() - 2592000, '/');
	session_destroy();
}
?>
```
Setting session time-out:
```php
ini_set('session.gc_maxlifetime', 60 * 60 * 24);
echo ini_get('session.gc_maxlifetime');
```
Session is not secure enough, as it is possible to use *packet sniffing* to
discover session IDs. Attacker can use session ID to achieve
***session hijacking***. The only secure way is to use ***https***.

When https is not possible, try adding another layer of checking:
```php
$_SESSION['ip'] = $_SERVER['REMOTE_ADDR'];
if ($_SESSION['ip'] != $_SERVER['REMOTE_ADDR'])
	different_user();//destroy session and ask for login again
$_SESSION['ua'] = $_SERVER['HTTP_USER_AGENT'];
if ($_SESSION['ua'] != $_SERVER['HTTP_USER_AGENT']) different_user();

$_SESSION['check'] = hash('ripemd128',
		$_SERVER['REMOTE_ADDR'] . $_SERVER['HTTP_USER_AGENT']);
```

**Session fixation**: user might type `sessiontest.php?PHPSESSID=1234` force
a session id to server, rather than the server creates its own. Attacker might
leave such urls to other users, so that they leave a backdoor that they can
came back later.

Prevent fixation by `session_regenerate_id();` to generate a different id.
Or use `ini_set('session.use_only_cookies', 1);` to enforce cookie-only session.

To set session save path to prevent other users accessing on a whared web server:
```
ini_set('session.save_path', '/home/user/myaccount/sessions');
```

## Chapter 13 Exloring Javascript

Hello world in Javascript:
```html
<html>
<head><title>Hello World</title></head>
<body>
	<script type="text/javascript">
		document.write("Hello World")
	</script>
	<noscript>
		Your browser doesn't support or has disabled JavaScript
	</noscript>
</body>
</html>
```

Javascript separate statements by newline. But semicolon still works.

Include javascript files:
```html
<script type="text/javascript" src="script.js"></script>
<script type="text/javascript" src="http://someserver.com/script.js"></script>
```

It is OK to leave out `type="text/javascript"`, javascript will be used in default.

In Firefox or Chrome, use Control+Shift+J to open javascript error console.

Like PHP, string literals can be enclosed by either ' or ", e.g."he" or 'he'.

## Miscellaneous

PHP Super Globals: http://www.w3schools.com/php/php_superglobals.asp

### REST

- REST == Representation State Transfer
- Resource-based
- Representations

6 constraints

1. Uniform Interface
2. Stateless
3. Client-server
4. Cacheable
5. Layered System
6. Code on demand

Creating a RESTful PHP API: http://coreymaynard.com/blog/creating-a-restful-api-with-php/
