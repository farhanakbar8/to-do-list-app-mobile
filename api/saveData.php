<?php
include "config.php";

$eventName = $_POST['eventName'];
$eventDesc = $_POST['eventDesc'];
$timeDate = $_POST['timeDate'];

$sql = "insert into event (eventName, eventDesc, timeDate) values ('$eventName', '$eventDesc', '$timeDate');";

if ($con->query($sql)) {
    echo "true";
} else {
    echo "false";
}
?>