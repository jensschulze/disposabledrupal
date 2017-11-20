<?php
$installerFile = __DIR__ . '/composer-setup.php';
$signature     = trim(file_get_contents('https://composer.github.io/installer.sig'));

echo 'WORKDIR: ' . __DIR__ . PHP_EOL;
echo 'Downloading Composer ... ';
if (copy('https://getcomposer.org/installer', $installerFile)) {
    echo 'Success!' . PHP_EOL;
} else {
    echo 'FAILED!' . PHP_EOL;
    exit(1);
}

$hashValue = hash_file('SHA384', $installerFile);
echo "File:      $hashValue" . PHP_EOL;
echo "Signature: $signature" . PHP_EOL;

if ($hashValue === $signature) {
    echo 'Installer verified' . PHP_EOL;
} else {
    echo 'Installer corrupt' . PHP_EOL;
    unlink('composer-setup.php');
    exit(1);
}

include $installerFile;
