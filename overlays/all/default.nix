self: super:

{
  alacritty-config   = self.callPackage ./alacritty-config {};
  git-config         = self.callPackage ./git-config {};
  i3-config          = self.callPackage ./i3-config {};
  i3status-config    = self.callPackage ./i3status-config {};
  chromium-config    = self.callPackage ./chromium-config {};
  dunst-config       = self.callPackage ./dunst-config {};
  less-config        = self.callPackage ./less-config {};
  most-config        = self.callPackage ./most-config {};
  rbrowser           = self.callPackage ./rbrowser {};
  rofi-config        = self.callPackage ./rofi-config {};
  surfingkeys-config = self.callPackage ./surfingkeys-config {};
  sway-config        = self.callPackage ./sway-config {};
  swm                = self.callPackage ./swm {};
  termite-config     = self.callPackage ./termite-config {};
  tmux-config        = self.callPackage ./tmux-config {};
  zsh-config         = self.callPackage ./zsh-config {};

  all = with self; buildEnv {
    name = "all";

    paths = [
      alacritty
      alacritty-config

      bat

      chromium
      chromium-config

      direnv

      firefox

      fzf

      git
      git-crypt
      git-config

      go
      dep
      swm

      i3-config
      i3status-config
      dunst dunst-config

      jq

      less-config

      mercurial

      mosh

      most
      most-config

      neovim
      gocode
      nodejs

      nix-index

      powerline-fonts

      rbrowser

      rofi-config

      surfingkeys-config

      sway-config

      termite-config

      tmux
      tmux-config

      zsh
      zsh-config
      nix-zsh-completions
    ];
  };
}
