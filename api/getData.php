<?php
include "config.php";
header("Access-Control-Allow-Origin: *");

$sql = "select * from event";
$result = array();
$res = $con->query($sql);
if ($res->num_rows > 0) {
    while ($row = $res->fetch_assoc()) {
        $result[] = $row;
    }
}
echo json_encode($result);
?>