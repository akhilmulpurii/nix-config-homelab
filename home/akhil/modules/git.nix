{ ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user.name = "Akhil Mulpuri";
      user.email = "akhilfilms02@gmail.com";
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
    };
  };
}
