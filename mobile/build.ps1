if ($args[0] -like 'web')
{
    flutter build web  --web-renderer canvaskit --release --source-maps
    Copy-Item -Path ".\build\web\*" -Destination "C:\Users\MehD\Desktop\Projects\viaq2\public-flutter" -Recurse -Force
    node C:\Users\MehD\Desktop\Projects\viaq2\index.js
}