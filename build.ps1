if ($args[0] -like 'web')
{
    flutter build web  --web-renderer canvaskit --release --source-maps
    Copy-Item -Path ".\build\web\*" -Destination "C:\Users\MehD\Desktop\Projects\01.old\Chisco\test\public-flutter" -Recurse -Force
    node C:\Users\MehD\Desktop\Projects\01.old\Chisco\test\index.js
}