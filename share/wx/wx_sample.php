<?php
/**
  * wechat php test
  */
// include implement class file
include_once "./Authentication.php";
include_once "./DistributeMessage.php";
//define your token
define("TOKEN", "wechat");
if(isset($_GET['echostr'])){
    $authen = new Authentication();
    $authen->valid();
}else{

    $distribute_msg = new DistributeMessage();
    $distribute_msg->responseMsg();
}

?>
