$org = "YOUR_GITHUB_USERNAME"
$targetUser = "YOUR_GITHUB_USERNAME"

$repos = gh repo list $org --limit 200 --json name -q ".[].name"

foreach ($repo in $repos) {
        $confirm = Read-Host "transfer $repo to $targetUser? (y/n)"

        if ($confirm -eq "y") {
                gh api `
                        -X POST `
                        "repos/$org/$repo/transfer" `
                        -f new_owner=$targetUser
        }
        else {
                Write-Host "skipped $repo"
        }
}