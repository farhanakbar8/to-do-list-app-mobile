<?php
include "config.php";
header("Access-Control-Allow-Origin: *");
$id=$_POST['id'];
$sql="delete from event where id=$id;";
if($con->query($sql))
{echo "true";}else
{echo "false";}
?>