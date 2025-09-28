# S'assurer que le dossier existe
New-Item -ItemType Directory -Force -Path "AT2/EX6-docker/app" | Out-Null

# Réécriture sans BOM
$path = "AT2/EX6-docker/app/composer.json"
$utf8NoBom = New-Object System.Text.UTF8Encoding($false)
[System.IO.File]::WriteAllText($path, @"
{
  "name": "ex6/demo",
  "description": "Mini app EX6 avec Monolog",
  "require": {
    "monolog/monolog": "^3.7"
  }
}
"@, $utf8NoBom)

# (Optionnel) vérifie que le fichier est bien là
Get-Item $path
