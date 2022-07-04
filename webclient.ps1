#To jest funcja powodująca, że nie są zgłaszane jakieś problemy z użyciem komend pobierających strony. To jest niezlalecane ale działa
#Użycie potem tego poprzez Set-UseUnsafeHeaderParsing -Enable
function Set-UseUnsafeHeaderParsing
{
    param(
        [Parameter(ParameterSetName='Enable')]
        [switch]$Enable,

        [Parameter(ParameterSetName='Disable')]
        [switch]$Disable
    )

    $ShouldEnable = $PSCmdlet.ParameterSetName -eq 'Enable'

    $netAssembly = [Reflection.Assembly]::GetAssembly([System.Net.Configuration.SettingsSection])

    if($netAssembly)
    {
        $bindingFlags = [Reflection.BindingFlags] 'Static,GetProperty,NonPublic'
        $settingsType = $netAssembly.GetType('System.Net.Configuration.SettingsSectionInternal')

        $instance = $settingsType.InvokeMember('Section', $bindingFlags, $null, $null, @())

        if($instance)
        {
            $bindingFlags = 'NonPublic','Instance'
            $useUnsafeHeaderParsingField = $settingsType.GetField('useUnsafeHeaderParsing', $bindingFlags)

            if($useUnsafeHeaderParsingField)
            {
              $useUnsafeHeaderParsingField.SetValue($instance, $ShouldEnable)
            }
        }
    }
}
Set-UseUnsafeHeaderParsing -Enable
$web = New-Object System.Net.WebClient
$url = "http://192.168.0.20"
$Web.OpenRead($url)
$web.UploadString($url, {pw=1})
