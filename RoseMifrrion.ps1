# clear
if (0)
{
    Remove-Item .\.hg -Force -Recurse -ErrorAction SilentlyContinue
    Invoke-Expression "hg init"
}
$repo="newrepo"
$total = 42000
$total = 11050
$step = 500
$num=$step
if (0)
{
   $total = 11250
   $num=11000
}

while ($num -le $total)
{
   $cmd = "hg pull https://expertchoice.kilnhg.com/Code/Core/CoreRepos/{0} --rev {1}" -f $repo, $num
   # $cmd = "hg pull --rev {0}" -f $num
   echo $cmd
   Invoke-Expression $cmd
   
   $num=$num+$step
}
