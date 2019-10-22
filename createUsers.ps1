Import-Module activedirectory
$Users = Import-csv C:\user_list.csv

foreach ($User in $Users)
{
		
	$Username 	= $User.username
	$Password 	= $User.password
	$Firstname 	= $User.firstname
	$Lastname 	= $User.lastname
	$OU 		= $User.ou
    $email      = $User.email
    $department = $User.department
    $Password = $User.Password

	if (Get-ADUser -F {SamAccountName -eq $Username})
	{
		 Write-Warning "User already exists: $Username"
	}
	else
	{
		New-ADUser `
            -SamAccountName $Username `
            -Name "$Firstname $Lastname" `
            -GivenName $Firstname `
            -Surname $Lastname `
            -Enabled $True `
            -Path $OU `
            -EmailAddress $email `
            -Department $department `
            -AccountPassword (convertto-securestring $Password -AsPlainText -Force)
            
	}
}
