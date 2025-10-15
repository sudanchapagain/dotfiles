$env.PATH ++= [
  '~/.local/bin'
  '~/.cargo/bin'
  $"/etc/profiles/per-user/($env.USER)/bin"
  "/run/current-system/sw/bin"
  "/usr/local/bin"
  "/usr/bin"
  "/usr/sbin"
  "/bin"
]

$env.JAVA_HOME = "/home/crimson/.jdks/openjdk-25"
$env.LS_COLORS = (vivid generate rose-pine-dawn)
