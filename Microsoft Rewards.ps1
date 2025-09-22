# Importation des assemblies nécessaires
Add-Type -AssemblyName System.Windows.Forms

# Création d'une variable globale pour suivre l'annulation et sa raison
$global:cancelled = $false
$global:cancelReason = ""

# Création d'une variable globale pour suivre la validation de l'avertissement
$global:warningConfirmed = $false

# Création du formulaire
$form = New-Object System.Windows.Forms.Form
$form.Text = [System.Text.Encoding]::UTF8.GetString([System.Text.Encoding]::Default.GetBytes("Sélection du nombre de recherches"))
$form.Size = New-Object System.Drawing.Size(380, 150)
$form.StartPosition = [System.Windows.Forms.FormStartPosition]::CenterScreen  # Centre la boîte de dialogue sur l'écran

# Gestionnaire d'événements pour la fermeture du formulaire
$form.Add_FormClosing({
    if (-not $global:warningConfirmed) {
        $global:cancelled = $true
        $global:cancelReason = "Le script a été annulé."
    }
})

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

    # Annuler le script si le nombre de recherches est supérieur à 40
    if ($script:maxRecherches -gt 40) {
        $global:cancelled = $true
        $form.Close()
    } else {
        # Vérifier si le nombre de recherches est supérieur à 30
        if ($script:maxRecherches -gt 30) {
            # Afficher un message d'avertissement avec deux boutons
            $warningForm = New-Object System.Windows.Forms.Form
            $warningForm.Text = [System.Text.Encoding]::UTF8.GetString([System.Text.Encoding]::Default.GetBytes("Avertissement"))
            $warningForm.Size = New-Object System.Drawing.Size(300, 150)
            $warningForm.StartPosition = [System.Windows.Forms.FormStartPosition]::CenterScreen  # Centre la boîte de dialogue sur l'écran

            $warningLabel = New-Object System.Windows.Forms.Label
            $warningLabel.TextAlign = [System.Drawing.ContentAlignment]::MiddleCenter  # Centrer le texte
            $warningLabel.Text = [System.Text.Encoding]::UTF8.GetString([System.Text.Encoding]::Default.GetBytes("Vous avez sélectionné plus de 30 recherches. Voulez-vous continuer ?"))
            $warningLabel.Size = New-Object System.Drawing.Size(250, 30)
            $warningLabel.Location = New-Object System.Drawing.Point(25, 30)
            $warningForm.Controls.Add($warningLabel)

            $continueBtn = New-Object System.Windows.Forms.Button
            $continueBtn.Text = [System.Text.Encoding]::UTF8.GetString([System.Text.Encoding]::Default.GetBytes("Continuer"))
            $continueBtn.Location = New-Object System.Drawing.Point(30, 70)
            $continueBtn.Add_Click({
                $global:warningConfirmed = $true
                $warningForm.Close()
            })
            $warningForm.Controls.Add($continueBtn)

            $cancelBtn = New-Object System.Windows.Forms.Button
            $cancelBtn.Text = [System.Text.Encoding]::UTF8.GetString([System.Text.Encoding]::Default.GetBytes("Annuler"))
            $cancelBtn.Location = New-Object System.Drawing.Point(150, 70)
            $cancelBtn.Add_Click({
                $global:warningConfirmed = $false
                $warningForm.Close()
            })
            $warningForm.Controls.Add($cancelBtn)

            $warningForm.ShowDialog()
        } else {
            $global:warningConfirmed = $true
        }

        if ($global:warningConfirmed) {
            # Déterminer le message approprié en fonction du nombre de recherches
            if ($script:maxRecherches -eq 1) {
                $message = "Vous avez sélectionné $script:maxRecherches recherche."
            } else {
                $message = "Vous avez sélectionné $script:maxRecherches recherches."
            }

            [System.Windows.Forms.MessageBox]::Show([System.Text.Encoding]::UTF8.GetString([System.Text.Encoding]::Default.GetBytes($message)), 
                                                   [System.Text.Encoding]::UTF8.GetString([System.Text.Encoding]::Default.GetBytes("Confirmation")), 
                                                   [System.Windows.Forms.MessageBoxButtons]::OK, 
                                                   [System.Windows.Forms.MessageBoxIcon]::Information)

            $form.Close()
            Write-Output $message
        } else {
            $global:cancelled = $true
            $global:cancelReason = "Le script a été annulé."
            $form.Close()
        }
    }
})

# Création du bouton Annuler
$cancelBtn = New-Object System.Windows.Forms.Button
$cancelBtn.Text = [System.Text.Encoding]::UTF8.GetString([System.Text.Encoding]::Default.GetBytes("Annuler"))
$cancelBtn.Location = New-Object System.Drawing.Point(150, 70)
$cancelBtn.Add_Click({
    $global:cancelled = $true
    $global:cancelReason = "Le script a été annulé."
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
    $okForm.StartPosition = [System.Windows.Forms.FormStartPosition]::CenterScreen  # Centre la boîte de dialogue sur l'écran

    $label = New-Object System.Windows.Forms.Label
    $label.TextAlign = [System.Drawing.ContentAlignment]::MiddleCenter  # Centrer le texte
    $label.Text = [System.Text.Encoding]::UTF8.GetString([System.Text.Encoding]::Default.GetBytes($global:cancelReason))
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

# Charger la liste des mots depuis les fichiers
# . "$PSScriptRoot\foot.ps1"
# Liste des fichiers disponibles
$listeFichiers = @(
    "$PSScriptRoot\dic2019_1.txt",
    "$PSScriptRoot\dic2019_2.txt",
    "$PSScriptRoot\dic2019_3.txt",
    "$PSScriptRoot\dic2019_4.txt",
    "$PSScriptRoot\dic2019_5.txt",
    "$PSScriptRoot\dic2019_6.txt",
    "$PSScriptRoot\dic2019_7.txt"
)

# Sélection aléatoire d’un fichier
$choixFichier = Get-Random -InputObject $listeFichiers

# Chargement des mots depuis le fichier sélectionné
$words1 = Get-Content $choixFichier -Encoding utf8

# Éventuel chargement de foot.ps1 si nécessaire
. "$PSScriptRoot\foot.ps1"

$random = New-Object System.Random # Création d'un objet Random

# Fonction pour supprimer les accents des caractères Unicode
function Remove-Accents {
    param ($text)
    $normalized = $text.Normalize([Text.NormalizationForm]::FormD)
    $sb = New-Object -TypeName System.Text.StringBuilder
    foreach ($char in $normalized.ToCharArray()) {
        if ([Globalization.CharUnicodeInfo]::GetUnicodeCategory($char) -ne 'NonSpacingMark') {
            [void]$sb.Append($char)
        }
    }
    return $sb.ToString()
}

# Mélanger les mots de manière aléatoire
$shuffledWords1 = $words1 | Sort-Object { $random.Next() }
$shuffledWords2 = $words2 | Sort-Object { $random.Next() }

# Fonction pour simuler la saisie de texte avec un délai aléatoire et des comportements humains
function Type-Text($text) {
    $shell = New-Object -ComObject wscript.shell # Initialisation de l'objet shell

    $text.ToCharArray() | ForEach-Object {
        # Générer une erreur de frappe isolée avec une probabilité de 3%
        if ($random.Next(0, 100) -lt 3) {
            $wrongChar = [char]($random.Next(77, 111)) # lettre aléatoire minuscule
            $shell.SendKeys($wrongChar)
            Start-Sleep -Milliseconds ($random.Next(50, 100))
            $shell.SendKeys("{BACKSPACE}")
            Start-Sleep -Milliseconds ($random.Next(100, 150))
        }

        # Simuler une confusion complète avec correction (1% de chance)
        if ($random.Next(0, 100) -eq 50) {
            $garbleLength = $random.Next(2, 5) # Nombre de caractères erronés
            for ($i = 0; $i -lt $garbleLength; $i++) {
                $garbleChar = [char]($random.Next(77, 111))
                $shell.SendKeys($garbleChar)
                Start-Sleep -Milliseconds ($random.Next(40, 80))
            }
            for ($i = 0; $i -lt $garbleLength; $i++) {
                $shell.SendKeys("{BACKSPACE}")
                Start-Sleep -Milliseconds ($random.Next(60, 120))
            }
            Start-Sleep -Milliseconds ($random.Next(75, 225)) # Pause de confusion
        }

        # Pause naturelle après un espace ou une ponctuation
        if ($_ -match "[\s.,;!?]") {
            Start-Sleep -Milliseconds ($random.Next(75, 225))
        }

        # Délai plus long pour les majuscules
        if ($_ -match "[A-Z]") {
            Start-Sleep -Milliseconds ($random.Next(75, 125)) # Simulation de shift ou frappe intentionnelle
        }

        # Générer un délai aléatoire entre 50 et 255 ms avec distribution personnalisée
        $chance = $random.Next(0, 100)
        if ($chance -lt 30) {
            $delay = $random.Next(50, 89)   # 30% : frappe rapide
        } elseif ($chance -lt 80) {
            $delay = $random.Next(90, 141)  # 50% : frappe normale
        } else {
            $delay = $random.Next(142, 256)  # 20% : frappe plus lente
        }

        $shell.SendKeys($_)
        Start-Sleep -Milliseconds $delay
    }
}

# Initialisation de la limite du nombre de recherches
if (-not $script:maxRecherches) {
    $script:maxRecherches = 2 # Valeur par défaut au cas où aucune valeur n'est sélectionnée
}
$compteur = 0

# Parcourir les mots mélangés
for ($i = 0; $i -lt [math]::Min($shuffledWords1.Length, $shuffledWords2.Length); $i++) {
    if ($compteur -ge $script:maxRecherches) {
        break
    }

    # Sélectionner aléatoirement une des deux listes pour les deux mots avec une probabilité de 25% pour $words2 (foot)
    $useWords2 = $random.Next(0, 4) -eq 0
    if ($useWords2) {
        $word2a = $shuffledWords2[$random.Next($shuffledWords2.Length)]
        $word2b = $shuffledWords2[$random.Next($shuffledWords2.Length)]
        while ($word2a -eq $word2b) {
            $word2b = $shuffledWords2[$random.Next($shuffledWords2.Length)]
        }
        $number = $random.Next(11, 100) # Générer un nombre aléatoire entre 11 et 99
        $url = "Foot $word2a vs $word2b $number"
    } else {
        $word1 = $shuffledWords1[$i]
        $url = "Definition de $word1"
    }

    # Ouvrir une nouvelle fenêtre du navigateur si nécessaire
    if ($compteur -eq 0) {
        $browserProcess = Start-Process $process -ArgumentList $baseUrl -PassThru
        Start-Sleep -Seconds 2 # Attendre que le navigateur s'ouvre
    }

    # Simuler la saisie du mot clé dans la barre de recherche Bing
    $shell = New-Object -ComObject wscript.shell # Initialisation de l'objet shell
    $shell.SendKeys("^e") # Placer le curseur dans la barre de recherche Bing (Ctrl+E)
    Start-Sleep -Milliseconds 350 # Attendre 350 ms pour s'assurer que le curseur est en place
    $cleanUrl = Remove-Accents $url
    Type-Text $cleanUrl
    $shell.SendKeys("{ENTER}") # Appuyer sur Entrée pour lancer la recherche

    # Générer un délai aléatoire entre 6000 et 14001 millisecondes
    $delay = $random.Next(5000, 14001)
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