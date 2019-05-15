<?php

class Db {
    private $dbhost = "localhost";
    private $dbuser = "root";
    private $dbpass = "root";
    private $dbname = "emyo";
	private $sitekey = "XrdfGtrg98456";

    public function connect(){
        $mysql_connection = "mysql:host=$this->dbhost;dbname=$this->dbname;charset=utf8";
        $connection = new PDO($mysql_connection,$this->dbuser,$this->dbpass);
        $connection->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        return $connection;
    }
	
/* API key encryption */
public function apiToken($user_id)
{
$key=md5($this->sitekey.$user_id);
return hash('sha256', $key);
}


}