{
  pkgs,
  pkgs-stable,
  username,
  host,
  inputs,
  ...
}:
let
  inherit (import ./variables.nix) gitUsername gitEmail;
in
{
  # Home Manager Settings
  home.username = "${username}";
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "23.11";

  # Import Program Configurations
  imports = [
    ../../config/emoji.nix
    ../../config/hyprland.nix
    ../../config/neovim.nix
    ../../config/rofi/rofi.nix
    ../../config/rofi/config-emoji.nix
    ../../config/rofi/config-long.nix
    ../../config/swaync.nix
    ../../config/waybar.nix
    ../../config/wlogout.nix
    inputs.jerry.homeManagerModules.default
  ];

  # Place Files Inside Home Directory
  home.file."Pictures/Wallpapers" = {
    source = ../../config/wallpapers;
    recursive = true;
  };
  home.file.".config/fastfetch" = {
    source = ../../config/fastfetch;
    recursive = true;
  };
    #home.file.".config/awesome" = {
    #source = ../../config/awesome;
    #recursive = true;
  #};
  home.file.".config/wlogout/icons" = {
    source = ../../config/wlogout;
    recursive = true;
  };
  home.file.".face.icon".source = ../../config/face.jpg;
  home.file.".config/face.jpg".source = ../../config/face.jpg;
  home.file.".config/swappy/config".text = ''
    [Default]
    save_dir=/home/${username}/Pictures/Screenshots
    save_filename_format=swappy-%Y%m%d-%H%M%S.png
    show_panel=false
    line_size=5
    text_size=20
    text_font=Ubuntu
    paint_mode=brush
    early_exit=true
    fill_shape=false
  '';
  # Install & Configure Git
  programs.git = {
    enable = true;
    userName = "${gitUsername}";
    userEmail = "${gitEmail}";
  };
  i18n.inputMethod.enabled = "fcitx5";
  i18n.inputMethod.fcitx5.addons = with pkgs; [ fcitx5-configtool fcitx5-mozc ];
  # Create XDG Dirs
  xdg = {
    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };

  xsession = {
    windowManager = {
      awesome = {
        enable = true;
        package = pkgs.awesomeGit;
      };
    };
  };

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };

  # Styling Options
  stylix.targets.waybar.enable = false;
  stylix.targets.rofi.enable = false;
  stylix.targets.hyprland.enable = false;
  stylix.targets.kde.enable = false;
  gtk = {
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };
  qt = {
    enable = true;
    style.name = "adwaita-dark";
    platformTheme.name = "gtk3";
  };


  # Scripts
  home.packages = [
    inputs.jerry.packages.${pkgs.system}.default
    (import ../../scripts/emopicker9000.nix { inherit pkgs; })
    (import ../../scripts/task-waybar.nix { inherit pkgs; })
    (import ../../scripts/squirtle.nix { inherit pkgs; })
    (import ../../scripts/nvidia-offload.nix { inherit pkgs; })
    (import ../../scripts/wallsetter.nix {
      inherit pkgs;
      inherit username;
    })
    (import ../../scripts/web-search.nix { inherit pkgs; })
    (import ../../scripts/rofi-launcher.nix { inherit pkgs; })
    (import ../../scripts/screenshootin.nix { inherit pkgs; })
    (import ../../scripts/list-hypr-bindings.nix {
      inherit pkgs;
      inherit host;
    })
  ];

  services = {
    flameshot = {
      enable = true;
      package = pkgs-stable.flameshot;
    };
    picom = {
      enable = true;
      activeOpacity = 1.0;
      inactiveOpacity = 1.0;
      shadow = true;
      shadowOffsets = [ (-25) (-25) ];
      shadowOpacity = 0.5;
      fade = false;
      fadeDelta = 3;
      fadeSteps = [
        0.03
        0.03
      ];
      settings = {
        shadow-radius = 25;
        corner-radius = 15;
      };
    };
    hypridle = {
      settings = {
        general = {
          after_sleep_cmd = "hyprctl dispatch dpms on";
          ignore_dbus_inhibit = false;
          lock_cmd = "hyprlock";
        };
        listener = [
          {
            timeout = 900;
            on-timeout = "hyprlock";
          }
          {
            timeout = 1200;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }
        ];
      };
    };
  };

  programs = {
    wezterm = {
        enable = true;
        enableZshIntegration = true;
        extraConfig = 
        ''
        return {
          hide_tab_bar_if_only_one_tab = true,
          enable_wayland = false
         }
           '';
    };
    zoxide = {
        enable = true;
        enableZshIntegration = true;
        options = [ "--cmd cd" ];
    };
    tmux = {
        enable = true;
        disableConfirmationPrompt = true;
        keyMode = "vi";
        mouse = true;
        baseIndex = 1;
        prefix = "C-Space";
        extraConfig = "unbind r \nbind r source-file ~/.config/tmux/tmux.conf \nset-option -sa terminal-overrides ',xterm*:Tc' \nset -g @resurrect-capture-pane-contents 'on'\nset -g @continuum-restore 'on'\nset-option -g status-position top \nbind-key -n C-l send-keys 'C-l' \nbind-key -n C-j previous-window \nbind-key -n C-k next-window \nbind-key -n 'M-h' 'select-pane -L'\nbind-key -n 'M-j' 'select-pane -D'\nbind-key -n 'M-k' 'select-pane -U'\nbind-key -n 'M-l' 'select-pane -R'\nset-option -g @catppuccin_flavour 'mocha' \nset-option -g @resurrect-strategy-nvim 'session' \nbind-key -T copy-mode-vi v send-keys -X begin-selection \nbind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle \nbind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel ";
        plugins = [ 
          pkgs.tmuxPlugins.resurrect 
          pkgs.tmuxPlugins.catppuccin 
          pkgs.tmuxPlugins.sensible 
          pkgs.tmuxPlugins.vim-tmux-navigator 
          pkgs.tmuxPlugins.yank 
          pkgs.tmuxPlugins.continuum
          pkgs.tmuxPlugins.weather
        ];
    };
    oh-my-posh = {
      enable = true;
      enableZshIntegration = false;
    };
    gh.enable = true;
    btop = {
      enable = true;
      settings = {
        vim_keys = true;
      };
    };
    starship = {
            enable = false;
            package = pkgs.starship;
          };
    kitty = {
      enable = true;
      package = pkgs.kitty;
      settings = {
        scrollback_lines = 2000;
        wheel_scroll_min_lines = 1;
        window_padding_width = 4;
        confirm_os_window_close = 0;
      };
      extraConfig = ''
        tab_bar_style fade
        tab_fade 1
        active_tab_font_style   bold
        inactive_tab_font_style bold
      '';
    };
    bash = {
      enable = true;
      enableCompletion = true;
      profileExtra = ''
        #if [ -z "$DISPLAY" ]; then
        #  exec awesome
        #fi
      '';
      initExtra = ''
        fastfetch
        if [ -f $HOME/.bashrc-personal ]; then
          source $HOME/.bashrc-personal
        fi
      '';
     shellAliases = {
        sv = "sudo nvim";
        fr = "nh os switch --hostname ${host} /home/${username}/zaneyos";
        fu = "nh os switch --hostname ${host} --update /home/${username}/zaneyos";
        zu = "sh <(curl -L https://gitlab.com/Zaney/zaneyos/-/raw/main/install-zaneyos.sh)";
        ncg = "nix-collect-garbage --delete-old && sudo nix-collect-garbage -d && sudo /run/current-system/bin/switch-to-configuration boot";
        v = "nvim";
        cat = "bat";
        ls = "eza --icons";
        ll = "eza -lh --icons --grid --group-directories-first";
        la = "eza -lah --icons --grid --group-directories-first";
        ".." = "cd ..";
        host = "nvim ~/zaneyos/hosts/dragneel/";
        config = "nvim ~/zaneyos/config/";
      };
    };
    vscode = {
      enable = false;
      extensions = with pkgs.vscode-extensions; [
        dracula-theme.theme-dracula
      ];
    };
    zsh = {
      enable = true;
      autosuggestion.enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      shellAliases = {
        sv = "sudo nvim";
        fr = "nh os switch --hostname ${host} /home/${username}/zaneyos";
        fu = "nh os switch --hostname ${host} --update /home/${username}/zaneyos";
        zu = "sh <(curl -L https://gitlab.com/Zaney/zaneyos/-/raw/main/install-zaneyos.sh)";
        ncg = "nix-collect-garbage --delete-old && sudo nix-collect-garbage -d && sudo /run/current-system/bin/switch-to-configuration boot";
        v = "nvim";
        cat = "bat";
        ls = "eza --icons";
        ll = "eza -lh --icons --grid --group-directories-first";
        la = "eza -lah --icons --grid --group-directories-first";
        host = "nvim ~/zaneyos/hosts/dragneel/";
        config = "nvim ~/zaneyos/config/";
        mp = "ncmpcpp";
        py-server = "python -m http.server 8040";
        py-virt = "source .venv/bin/activate";
        py-virtc = "python3 -m venv .venv";
        zsh-e = "v ~/.zshrc";
        reload = "source ~/.zshrc";
        nix-dev = "tmuxifier load-session nix";
        awm = "tmuxifier load-session awm";
      };
      defaultKeymap = "emacs";
      history = {
        ignoreAllDups = true;
        path = "$HOME/.zsh_history";
        save = 10000;
        size = 10000;
      };
      profileExtra = ''
        #if [ -z "$DISPLAY" ]; then
        #  exec awesome
        #fi
      '';
      initExtra = ''
        fastfetch
        eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/dracula.omp.json)"
        zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
        zstyle ':completion:*' menu no
        zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls $realpath'
        zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls $realpath'
        eval "$(fzf --zsh)"
      '';
      plugins = [
        {
          name = "zsh-autosuggestions";
          src = pkgs.zsh-autosuggestions;
        }
        {
          name = "zsh-syntax-highlighting";
          src = pkgs.zsh-syntax-highlighting;
        }
        #{
          #name = "powerlevel10k";
          #src = pkgs.zsh-powerlevel10k;
          #file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        #}
        {
          name = "fzf-tab";
          src = pkgs.zsh-fzf-tab;
        }
      ];
    };
    home-manager.enable = true;
    hyprlock = {
      enable = true;
      settings = {
        general = {
          disable_loading_bar = true;
          grace = 10;
          hide_cursor = true;
          no_fade_in = false;
        };
        background = [
          {
            path = "/home/${username}/Pictures/Wallpapers/zaney-wallpaper.jpg";
            blur_passes = 3;
            blur_size = 8;
          }
        ];
        image = [
          {
            path = "/home/${username}/.config/face.jpg";
            size = 150;
            border_size = 4;
            border_color = "rgb(0C96F9)";
            rounding = -1; # Negative means circle
            position = "0, 200";
            halign = "center";
            valign = "center";
          }
        ];
        input-field = [
          {
            size = "200, 50";
            position = "0, -80";
            monitor = "";
            dots_center = true;
            fade_on_empty = false;
            font_color = "rgb(CFE6F4)";
            inner_color = "rgb(657DC2)";
            outer_color = "rgb(0D0E15)";
            outline_thickness = 5;
            placeholder_text = "Password...";
            shadow_passes = 2;
          }
        ];
      };
    };
  };
}
