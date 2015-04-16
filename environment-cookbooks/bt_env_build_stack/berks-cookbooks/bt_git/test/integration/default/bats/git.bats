#!/usr/bin/env bats

@test "git is installed " {
  run git --version
  [ "$status" -eq 0 ]
}

@test "git is installed in the correct place " {
  run [ -d /usr/share/git-core ]
  [ "$status" -eq 0 ]
}

