$web = New-Object System.Net.Http.HttpClient

$uri="http://192.168.0.20"
$web.GetAsync($uri)