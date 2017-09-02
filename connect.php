<?php
$dbhost             = "localhost";
$dbuser             = "root";
$dbpass             = "root";
$dbname             = "registerandlogin";

$connection = mysqli_connect($dbhost,$dbuser,$dbpass) or die ("MySql connection problem");
mysqli_select_db($connection,$dbname) or die ("Database connection error");
?>
