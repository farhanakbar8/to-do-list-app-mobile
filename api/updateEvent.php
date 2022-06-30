<?php
include "config.php";

$eventName = $_POST['eventName'];
$eventDesc = $_POST['eventDesc'];
$timeDate = $_POST['timeDate'];
$id = $_POST['id'];

if ($eventName != "" && $eventDesc != "" && $timeDate != "") {
    $sql = "update event set eventName='$eventName', eventDesc='$eventDesc', timeDate='$eventDesc' where id='$id';";
    if ($con->query($sql)) {
        echo "true";
    } else {
        echo "false";
    }
}
?>