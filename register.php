<?php

header('Content-Type: text/html; charset=UTF-8');
//veritabanı bağlantı dosyası
include_once "connect.php";

//kayıt  formu verileri
$name = $_POST['name'];
$lastName	= $_POST['lastName'];
$email	= $_POST['email'];
$password	= $_POST['password'];

//sorguu
$sorgu="INSERT INTO users (name,lastname,email,password) VALUES ('{$name}','{$lastName}','{$email}','{$password}')";

//kontrol
$check=mysqli_query($connection,"SELECT * FROM users WHERE email='".$email."'");


if(mysqli_num_rows($check) > 0)
{
  $response['durum']='hatali';
  $response['mesaj']= $email. "e-mail adresi zaten var" ;
}

else
{
  if(mysqli_query($connection, $sorgu))
  {
    $response['durum']='basarili';
    $response['mesaj']="kayit basarili";
  }
  else {
    $response['durum']='hatali';
    $response['mesaj']="ERROR: " . $sorgu ;
  }

  echo json_encode($response);
}
mysql_close($connection);
?>
