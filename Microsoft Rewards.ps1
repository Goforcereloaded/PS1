# Importation des assemblies nécessaires
Add-Type -AssemblyName System.Windows.Forms

# Création d'une variable globale pour suivre l'annulation
$global:cancelled = $false

# Création du formulaire
$form = New-Object System.Windows.Forms.Form
$form.Text = [System.Text.Encoding]::UTF8.GetString([System.Text.Encoding]::Default.GetBytes("Sélection du nombre de recherches"))
$form.Size = New-Object System.Drawing.Size(300, 150)

# Création de la boîte de texte
$textBox = New-Object System.Windows.Forms.TextBox
$textBox.Location = New-Object System.Drawing.Point(30, 30)
$form.Controls.Add($textBox)

# Création du bouton pour soumettre la sélection
$submitBtn = New-Object System.Windows.Forms.Button
$submitBtn.Text = [System.Text.Encoding]::UTF8.GetString([System.Text.Encoding]::Default.GetBytes("Valider"))
$submitBtn.Location = New-Object System.Drawing.Point(30, 70)
$submitBtn.Add_Click({
    $selection = $textBox.Text

    # Définir la limite du nombre de recherches
    $script:maxRecherches = [int]$selection

    # Déterminer le message approprié en fonction du nombre de recherches
    if ($script:maxRecherches -eq 1) {
        $message = "Vous avez sélectionné $script:maxRecherches recherche."
    } else {
        $message = "Vous avez sélectionné $script:maxRecherches recherches."
    }

    [System.Windows.Forms.MessageBox]::Show([System.Text.Encoding]::UTF8.GetString([System.Text.Encoding]::Default.GetBytes($message)), [System.Text.Encoding]::UTF8.GetString([System.Text.Encoding]::Default.GetBytes("Confirmation")))
    
    $form.Close()
    Write-Output $message
})

# Création du bouton Annuler
$cancelBtn = New-Object System.Windows.Forms.Button
$cancelBtn.Text = [System.Text.Encoding]::UTF8.GetString([System.Text.Encoding]::Default.GetBytes("Annuler"))
$cancelBtn.Location = New-Object System.Drawing.Point(150, 70)
$cancelBtn.Add_Click({
    $global:cancelled = $true
    $form.Close()
})

# Ajout des boutons au formulaire
$form.Controls.Add($submitBtn)
$form.Controls.Add($cancelBtn)

# Définir le bouton de validation comme bouton par défaut
$form.AcceptButton = $submitBtn

# Définir le bouton Annuler comme bouton Annuler par défaut
$form.CancelButton = $cancelBtn

# Affichage du formulaire
$form.ShowDialog()

# Vérifier si le script a été annulé
if ($global:cancelled) {
    $okForm = New-Object System.Windows.Forms.Form
    $okForm.Text = [System.Text.Encoding]::UTF8.GetString([System.Text.Encoding]::Default.GetBytes("Annulation"))
    $okForm.Size = New-Object System.Drawing.Size(300, 150)

    $label = New-Object System.Windows.Forms.Label
    $label.Text = [System.Text.Encoding]::UTF8.GetString([System.Text.Encoding]::Default.GetBytes("Le script a été annulé."))
    $label.Size = New-Object System.Drawing.Size(250, 30)
    $label.Location = New-Object System.Drawing.Point(25, 30)
    $okForm.Controls.Add($label)

    $okButton = New-Object System.Windows.Forms.Button
    $okButton.Text = "OK"
    $okButton.Location = New-Object System.Drawing.Point(100, 70)
    $okButton.Add_Click({
        $okForm.Close()
    })
    $okForm.Controls.Add($okButton)

    $okForm.ShowDialog()
    Start-Sleep -Seconds 1 # Ajouter un délai avant la fermeture du script
    exit
}

# Script principal
$process = "msedge" # Nom du processus à lancer
$baseUrl = "https://www.bing.com/" # URL de Bing

# Charger la liste des mots depuis le fichier words1.ps1
. "$PSScriptRoot\words1.ps1"

$words2 = @(
    "PSG", "Marseille", "Lyon", "Monaco", "Lille", "Rennes", "Nice", "Strasbourg", "Montpellier", 
    "Nantes", "Saint-Etienne", "Reims", "Bordeaux", "Angers", "Metz", "Brest", "Troyes", "Lorient", 
    "Clermont", "Lens", "Anderlecht", "Club Brugge", "Genk", "Gent", "Standard Liege", "Royal Antwerp", 
    "Charleroi", "Zulte Waregem", "KV Mechelen", "OH Leuven", "Eupen", "Cercle Brugge", "Sint-Truiden", 
    "KV Kortrijk", "Waasland-Beveren", "Seraing", "Beerschot", "Westerlo"
)

$random = New-Object System.Random # Création d'un objet Random

# Mélanger les mots de manière aléatoire
$shuffledWords1 = $words1 | Sort-Object { $random.Next() }
$shuffledWords2 = $words2 | Sort-Object { $random.Next() }

# Fonction pour simuler la saisie de texte avec un délai aléatoire
function Type-Text($text) {
    $shell = New-Object -ComObject wscript.shell # Initialisation de l'objet shell
    $text.ToCharArray() | ForEach-Object {
        # Générer un délai aléatoire entre 50 et 70 ms avec une chance de 1%, sinon entre 71 et 211 ms
        if ($random.Next(0, 100) -lt 1) {
            $delay = $random.Next(50, 71)
        } else {
            $delay = $random.Next(71, 212)
        }
        $shell.SendKeys($_)
        Start-Sleep -Milliseconds $delay # Délai aléatoire entre 50 et 70 ms ou 71 et 211 ms
    }
}

# Initialisation de la limite du nombre de recherches
if (-not $script:maxRecherches) {
    $script:maxRecherches = 4 # Valeur par défaut au cas où aucune valeur n'est sélectionnée
}
$compteur = 0

# Parcourir les mots mélangés
for ($i = 0; $i -lt [math]::Min($shuffledWords1.Length, $shuffledWords2.Length); $i++) {
    if ($compteur -ge $script:maxRecherches) {
        break
    }

    # Sélectionner aléatoirement une des deux listes pour les deux mots
    $useWords1 = $random.Next(2) -eq 0
    if ($useWords1) {
        $word1 = $shuffledWords1[$i]
        $url = "definition de $word1"
    } else {
        $word2a = $shuffledWords2[$random.Next($shuffledWords2.Length)]
        $word2b = $shuffledWords2[$random.Next($shuffledWords2.Length)]
        while ($word2a -eq $word2b) {
            $word2b = $shuffledWords2[$random.Next($shuffledWords2.Length)]
        }
        $number = $random.Next(11, 102) # Générer un nombre aléatoire entre 11 et 101
        $url = "Foot $word2a vs $word2b $number"
    }

    # Ouvrir une nouvelle fenêtre du navigateur si nécessaire
    if ($compteur -eq 0) {
        $browserProcess = Start-Process $process -ArgumentList $baseUrl -PassThru
        Start-Sleep -Seconds 2 # Attendre que le navigateur s'ouvre
    }

    # Simuler la saisie du mot clé dans la barre de recherche Bing
    $shell = New-Object -ComObject wscript.shell # Initialisation de l'objet shell
    $shell.SendKeys("^e") # Placer le curseur dans la barre de recherche Bing (Ctrl+E)
    Start-Sleep -Milliseconds 300 # Attendre 300 ms pour s'assurer que le curseur est en place
    Type-Text $url
    $shell.SendKeys("{ENTER}") # Appuyer sur Entrée pour lancer la recherche

    # Générer un délai aléatoire entre 5000 et 9001 millisecondes
    $delay = $random.Next(5000, 9001)
    # Attendre le délai spécifié
    Start-Sleep -Milliseconds $delay

    # Incrémenter le compteur
    $compteur++
}

# Affichage du message de fin d'exécution avec UTF-8
$message = [System.Text.Encoding]::UTF8.GetString([System.Text.Encoding]::Default.GetBytes("Le script est terminé."))
$title = [System.Text.Encoding]::UTF8.GetString([System.Text.Encoding]::Default.GetBytes("Fin de l'exécution"))
[System.Windows.Forms.MessageBox]::Show($message, $title)

# Fermer la fenêtre du script PowerShell
exit
