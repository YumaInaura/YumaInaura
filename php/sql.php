<?php

$mysqli = new mysqli('localhost', 'root', '', 'example');

$stmt = $mysqli->prepare("INSERT INTO users(id, name) VALUES (?, ?)");

// $stmt->bind_param('sss', $id, $name);
$stmt->bind_param('is', $id, $name);

$id = 2;
$name = "ABC";

$stmt->execute();
