<?php

header('Content-Type: text/html; charset=UTF-8');
//veritabanı bağlantı dosyası
include_once "connect.php";

//giriş  formu verileri
$email	= $_POST['email'];
$password	= $_POST['password'];

//sorguu
$sorgu="select email,password from users where email='"  .  $email  . "' and password='" .$password . "'";
$result = mysqli_query($connection,$sorgu);
$row=mysqli_fetch_array($result,MYSQLI_ASSOC);

if(mysqli_num_rows($result) > 0)
{
  if(!empty($row))
  {
    $response['durum']='basarili';
    $response['mesaj']="giris yapildi";
    $returnValue = $row;
  }
}

else
{
$response['durum']='hatali';
$response['mesaj']="HATA: kullanici yok";
}

echo json_encode($response);
mysql_close($connection);

?>
