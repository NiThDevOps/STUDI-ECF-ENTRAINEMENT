<?php
$version = getenv('APP_VERSION') ?: '0.0.0';
header('Content-Type: application/json');
echo json_encode(['app'=>'ex6-demo','version'=>$version,'php'=>PHP_VERSION]);
