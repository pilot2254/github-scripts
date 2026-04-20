$targetUser = "YOUR_GITHUB_USERNAME"

$repos = gh repo list $targetUser --limit 200 --json name, visibility | ConvertFrom-Json

foreach ($r in $repos) {
        if ($r.visibility -eq "PUBLIC") {
                $confirm = Read-Host "make $($r.name) private? (y/n)"

                if ($confirm -eq "y") {
                        gh api `
                                -X PATCH `
                                "repos/$targetUser/$($r.name)" `
                                -f private=true

                        Write-Host "$($r.name) -> private"
                }
                else {
                        Write-Host "skipped $($r.name)"
                }
        }
}