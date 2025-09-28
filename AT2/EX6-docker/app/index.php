<?php
require __DIR__ . '/vendor/autoload.php';
use Monolog\Logger;
use Monolog\Handler\StreamHandler;

$logger = new Logger('ex6');
$logger->pushHandler(new StreamHandler(__DIR__.'/storage/app.log', Logger::INFO));
$version = getenv('APP_VERSION') ?: '0.0.0';
$logger->info("App start", ['version' => $version]);
?>
<!doctype html><html><head><meta charset="utf-8"><title>EX6 Demo</title></head>
<body>
<h1>EX6 — PHP + Composer</h1>
<p>Version : <strong><?= htmlspecialchars($version) ?></strong></p>
<p>PHP : <?= PHP_VERSION ?></p>
<p><a href="/version.php">/version.php</a></p>
</body></html>
