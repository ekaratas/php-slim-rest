<?php
use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;

$app = new \Slim\App;

$app->add(function ($req, $res, $next) {
    $response = $next($req, $res);
    return $response
            ->withHeader('Access-Control-Allow-Origin', '*')
            ->withHeader('Access-Control-Allow-Headers', 'X-Requested-With, Content-Type, Accept, Origin, Authorization')
            ->withHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, PATCH, OPTIONS');
});

// tüm mesajları getir...
$app->get('/mesajlar', function (Request $request, Response $response) {

    $db = new Db();
    try{
        $db = $db->connect();

        $mesajlar = $db->query("SELECT * FROM feed")->fetchAll(PDO::FETCH_OBJ);

		
	
        return $response
            ->withStatus(200)
            ->withHeader("Content-Type", 'application/json')
            ->withJson($mesajlar, null, JSON_UNESCAPED_UNICODE | JSON_NUMERIC_CHECK);

    }catch(PDOException $e){
        return $response->withJson(
            array(
                "error" => array(
                    "text"  => $e->getMessage(),
                    "code"  => $e->getCode()
                )
            ), null, JSON_UNESCAPED_UNICODE | JSON_NUMERIC_CHECK
        );
    }
    $db = null;
});

// kullanıcı mesajlarını getir..
$app->get('/mesajlar/{id}', function (Request $request, Response $response) {

    $id = $request->getAttribute("id");
    $db = new Db();
    try{
        $db = $db->connect();
        $mesajlar = $db->query("SELECT * FROM feed WHERE user_id_fk = $id")->fetchAll(PDO::FETCH_OBJ);

        return $response
            ->withStatus(200)
            ->withHeader("Content-Type", 'application/json')
            ->withJson($mesajlar, null, JSON_UNESCAPED_UNICODE | JSON_NUMERIC_CHECK);

    }catch(PDOException $e){
        return $response->withJson(
            array(
                "error" => array(
                    "text"  => $e->getMessage(),
                    "code"  => $e->getCode()
                )
            ), null, JSON_UNESCAPED_UNICODE | JSON_NUMERIC_CHECK
        );
    }
    $db = null;
});


$app->post('/kayit', function (Request $request, Response $response) {

    $username = $request->getParam("username");
    $name = $request->getParam("name");
    $passwordr = $request->getParam("password");
	$email = $request->getParam("email");

    $db = new Db();
	//$testToken = new Db();
    try{        
        
        $username_check = preg_match('~^[A-Za-z0-9_]{3,20}$~i', $username);
        $email_check = preg_match('~^[a-zA-Z0-9._-]+@[a-zA-Z0-9._-]+\.([a-zA-Z]{2,4})$~i', $email);
        $password_check = preg_match('~^[A-Za-z0-9!@#$%^&*()_]{6,20}$~i', $passwordr);

        if (strlen(trim($username))>0 && strlen(trim($passwordr))>0 && strlen(trim($email))>0 && $email_check>0 && $username_check>0 && $password_check>0)
        {

        $db = $db->connect();
		

	        $userData = '';
            $sql = "SELECT user_id FROM users WHERE username=:username or email=:email";
            $stmt = $db->prepare($sql);
            $stmt->bindParam("username", $username);
            $stmt->bindParam("email", $email);
            $stmt->execute();
            $mainCount=$stmt->rowCount();
            //$created=time();
			
            if($mainCount==0)
            {
				
				/*Inserting user values*/
                $sql1="INSERT INTO users(username,password,email,name)VALUES(:username,:password,:email,:name)";
                $stmt1 = $db->prepare($sql1);
                $stmt1->bindParam("username", $username);
                $password=hash('sha256',$passwordr);
                $stmt1->bindParam("password", $password);
                $stmt1->bindParam("email", $email);
                $stmt1->bindParam("name", $name);
                $stmt1->execute();

				
                //$testToken = $testToken->apiToken($email);
				
		        $user=internalUserDetails($email);
							
			
			// return $response
            // ->withStatus(200)
            // ->withHeader("Content-Type", 'application/json')
            // ->withJson($userData);
			

            return $response
                 ->withStatus(200)
                 ->withHeader("Content-Type", 'application/json')
                 //->withJson($user->token);
                 ->withJson($user, null, JSON_UNESCAPED_UNICODE | JSON_NUMERIC_CHECK);
		
			}
			else
			{
            return $response
                ->withStatus(400)
                ->withHeader("Content-Type", 'application/json')
                ->withJson(array(
                    "error" => array(
                        "text"  => "Bu kullanıcı kayıtlı!"
                    )
                ), null, JSON_UNESCAPED_UNICODE | JSON_NUMERIC_CHECK);
			}

    }
    else
    {
        return $response
            ->withStatus(400)
            ->withHeader("Content-Type", 'application/json')
            ->withJson(array(
                "error" => array(
                    "text"  => "Girdiğiniz bilgileri kontrol ediniz !"
                )
            ), null, JSON_UNESCAPED_UNICODE | JSON_NUMERIC_CHECK);
        }

}
    catch(PDOException $e){
        return $response->withJson(
            array(
                "error" => array(
                    "text"  => $e->getMessage(),
                    "code"  => $e->getCode()
                )
            ),null, JSON_UNESCAPED_UNICODE | JSON_NUMERIC_CHECK
        );
    }
    $db = null;
});

$app->post('/giris', function (Request $request, Response $response) {

    $username = $request->getParam("username");
    $passwordr = $request->getParam("password");

    $db = new Db();
    try{
		
        $db = $db->connect();
        $userData ='';
		$statement = "SELECT * FROM users WHERE (username=:username or email=:username) and password=:password";
		$prepare = $db->prepare($statement);
		
	
        $prepare->bindParam("username", $username);
        $password=hash('sha256',$passwordr);
        $prepare->bindParam("password", $password);
		
		$course = $prepare->execute();
		$userData = $prepare->fetch(PDO::FETCH_OBJ);
		
        
		

            if($userData){
				$user=internalUserDetails($userData->username);
            return $response
            ->withStatus(200)
            ->withHeader("Content-Type", 'application/json')
            //->withJson($user->token);
            ->withJson($user, null, JSON_UNESCAPED_UNICODE | JSON_NUMERIC_CHECK);
        }
	
		
		else {
            return $response
                ->withStatus(401)
                ->withHeader("Content-Type", 'application/json')
                ->withJson(array(
                    "error" => array(
                        "text"  => "Login işlemi sırasında bir problem oluştu."
                    )
                ), null, JSON_UNESCAPED_UNICODE | JSON_NUMERIC_CHECK);
        }

    }catch(PDOException $e){
        return $response->withJson(
            array(
                "error" => array(
                    "text"  => $e->getMessage(),
                    "code"  => $e->getCode()
                )
            ), null, JSON_UNESCAPED_UNICODE | JSON_NUMERIC_CHECK
        );
    }
    $db = null;
});

// yeni mesaj ekle...
$app->post('/mesaj_ekle', function (Request $request, Response $response) {

    $username = $request->getParam("username");
    $feed    = $request->getParam("feed");
    $token_request = $request->getParam("token");
   
    $user=internalUserDetails($username);



    if ($user->token == $token_request)
    {

    $db = new Db();
    try{
        $db = $db->connect();
        $statement = "INSERT INTO feed (feed,user_id_fk,created) VALUES(:feed, :user_id, :time)";
        $prepare = $db->prepare($statement);

        $prepare->bindParam("feed", $feed);
        $prepare->bindParam("time", time());
        $prepare->bindParam("user_id", $user->user_id);

        $mesaj = $prepare->execute();

        if($mesaj){
            return $response
                ->withStatus(200)
                ->withHeader("Content-Type", 'application/json')
                ->withJson(array(
                    "text"  => "Kayıt başarılı bir şekilde eklenmiştir.."
                ), null, JSON_UNESCAPED_UNICODE | JSON_NUMERIC_CHECK);

        } else {
            return $response
                ->withStatus(401)
                ->withHeader("Content-Type", 'application/json')
                ->withJson(array(
                    "error" => array(
                        "text"  => "Ekleme işlemi sırasında bir problem oluştu."
                    )
                ), null, JSON_UNESCAPED_UNICODE | JSON_NUMERIC_CHECK);
        }

    }catch(PDOException $e){
        return $response->withJson(
            array(
                "error" => array(
                    "text"  => $e->getMessage(),
                    "code"  => $e->getCode()
                )
            ), null, JSON_UNESCAPED_UNICODE | JSON_NUMERIC_CHECK
        );
    }
    $db = null;
}
else {
    return $response
        ->withStatus(400)
        ->withHeader("Content-Type", 'application/json')
        ->withJson(array(
            "error" => array(
                "text"  => "Geçersiz kullanıcı, Ekleme işlemi sırasında bir problem oluştu."
                //"text"  => $user
            )
        ), null, JSON_UNESCAPED_UNICODE | JSON_NUMERIC_CHECK);
}

});


// mesaj güncelle..
$app->post('/mesaj/guncelle/{id}', function (Request $request, Response $response) {

    $id = $request->getAttribute("id");

    if($id)
    {

        $username = $request->getParam("username");
        $feed    = $request->getParam("feed");
        $token_request = $request->getParam("token");
       
        $user=internalUserDetails($username);
    
        if ($user->token == $token_request)
        {
        $db = new Db();
        try{
            $db = $db->connect();
            $statement = "UPDATE feed SET feed = :feed, created = :time WHERE feed_id = $id";
            $prepare = $db->prepare($statement);

            $prepare->bindParam("feed", $feed);
            $prepare->bindParam("time", time());

            $mesaj = $prepare->execute();

            if($mesaj){
                return $response
                    ->withStatus(200)
                    ->withHeader("Content-Type", 'application/json')
                    ->withJson(array(
                        "text"  => "Mesaj başarılı bir şekilde güncellenmiştir.."
                    ), null, JSON_UNESCAPED_UNICODE | JSON_NUMERIC_CHECK);

            } else {
                return $response
                    ->withStatus(500)
                    ->withHeader("Content-Type", 'application/json')
                    ->withJson(array(
                        "error" => array(
                            "text"  => "Düzenleme işlemi sırasında bir problem oluştu."
                        )
                    ), null, JSON_UNESCAPED_UNICODE | JSON_NUMERIC_CHECK);
            }
        }catch(PDOException $e){
            return $response->withJson(
                array(
                    "error" => array(
                        "text"  => $e->getMessage(),
                        "code"  => $e->getCode()
                    )
                ), null, JSON_UNESCAPED_UNICODE | JSON_NUMERIC_CHECK
            );
        }
        $db = null;
    } else {
        return $response
            ->withStatus(400)
            ->withHeader("Content-Type", 'application/json')
            ->withJson(array(
                "error" => array(
                    "text"  => "Geçersiz kullanıcı, Düzenleme işlemi sırasında bir problem oluştu."
                    //"text"  => $user
                )
            ), null, JSON_UNESCAPED_UNICODE | JSON_NUMERIC_CHECK);
    }
    }    else {
        return $response->withStatus(500)->withJson(
            array(
                "error" => array(
                    "text"  => "ID bilgisi eksik.."
                )
            ), null, JSON_UNESCAPED_UNICODE | JSON_NUMERIC_CHECK
        );
    } 
});

// mesaj sil..
$app->post('/sil/{id}', function (Request $request, Response $response) {

    $id = $request->getAttribute("id");


    if($id)
    {

    $username = $request->getParam("username");
    $token_request = $request->getParam("token");
   
    $user=internalUserDetails($username);


    if ($user->token == $token_request)
    {

    $db = new Db();
    try{
        $db = $db->connect();
        $statement = "DELETE FROM feed WHERE feed_id = :id";
        $prepare = $db->prepare($statement);
        $prepare->bindParam("id", $id);

        $mesaj = $prepare->execute();

        if($mesaj){
            return $response
                ->withStatus(200)
                ->withHeader("Content-Type", 'application/json')
                ->withJson(array(
                    "text"  => "Mesaj başarılı bir şekilde silinmiştir.."
                ));

        } else {
            return $response
                ->withStatus(400)
                ->withHeader("Content-Type", 'application/json')
                ->withJson(array(
                    "error" => array(
                        "text"  => "Silme işlemi sırasında bir problem oluştu."
                    )
                ), null, JSON_UNESCAPED_UNICODE | JSON_NUMERIC_CHECK);
        }

    }catch(PDOException $e){
        return $response->withJson(
            array(
                "error" => array(
                    "text"  => $e->getMessage(),
                    "code"  => $e->getCode()
                )
            ), null, JSON_UNESCAPED_UNICODE | JSON_NUMERIC_CHECK
        );
    }
    $db = null;
} else {
    return $response
        ->withStatus(400)
        ->withHeader("Content-Type", 'application/json')
        ->withJson(array(
            "error" => array(
                "text"  => "Geçersiz kullanıcı, Düzenleme işlemi sırasında bir problem oluştu."
                //"text"  => $user
            )
        ), null, JSON_UNESCAPED_UNICODE | JSON_NUMERIC_CHECK);
}

}  else {
    return $response->withStatus(500)->withJson(
        array(
            "error" => array(
                "text"  => "ID bilgisi eksik.."
            )
        ), null, JSON_UNESCAPED_UNICODE | JSON_NUMERIC_CHECK
    );
} 
});

function internalUserDetails($input) {
    $db = new Db();
	$testToken = new Db();
    try {
        $db = $db->connect();
        $sql = "SELECT user_id, name, email, username FROM users WHERE username=:input or email=:input";
        $stmt = $db->prepare($sql);
        $stmt->bindParam("input", $input);
        $stmt->execute();
        $usernameDetails = $stmt->fetch(PDO::FETCH_OBJ);
		$token = $testToken->apiToken($usernameDetails->user_id);
		//$token = $db->apiToken($usernameDetails->user_id);
        $usernameDetails->token = $token;
        $db = null;
        return $usernameDetails;
        //return $token;
        
    } catch(PDOException $e){
        return $response->withJson(
            array(
                "error" => array(
                    "text"  => $e->getMessage(),
                    "code"  => $e->getCode()
                )
            ), null, JSON_UNESCAPED_UNICODE | JSON_NUMERIC_CHECK
        );
    }
    
}
