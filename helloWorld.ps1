param (
    [Parameter()]
    $UserName
)

$message = "Hello $UserName from a GitHub action!"

echo "::set-output name=message::$message"