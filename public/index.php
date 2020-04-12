<?php

declare(strict_types=1);

echo 'Hello World<br><br>';

$dbHost = getenv('DB_HOST');
$dbPort = getenv('DB_PORT') ?: '3306';
$dbName = getenv('DB_DATABASE');

$dsn = [
    'mysql:host=' . $dbHost,
    'port=' . $dbPort,
    'dbname=' . $dbName,
];

$pdo = new PDO(
    implode(';', $dsn),
    (string) getenv('DB_USER'),
    (string) getenv('DB_PASSWORD'),
    [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
        PDO::ATTR_EMULATE_PREPARES => false,
    ]
);

$statement = $pdo->query('SHOW DATABASES');

$statement->execute();

$results = $statement->fetchAll();

var_dump($results);

echo '<br><br>';

phpinfo();
