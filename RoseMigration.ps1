clear
if (1)
{
    Remove-Item .\.hg -Force -Recurse -ErrorAction SilentlyContinue
    Invoke-Expression "hg init"
}
$repo="Core"
$total = 42000
$step = 50
$num=$step

while ($num -le $total)
{
   $cmd = "hg pull https://expertchoice.kilnhg.com/Code/Core/CoreRepos/{0} --rev {1}" -f $repo, $num
   echo $cmd
   Invoke-Expression $cmd
   
   $num=$num+$step
}