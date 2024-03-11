{pkgs, ...}: {
  home.packages = with pkgs; [
    comma
    fd
    xcp
    bottom
    curlie
    ffmpeg
    du-dust
    ripgrep
    cpulimit
    parallel
    watchexec
    hyperfine
    vhs
    pop
    gum
    glow
    flyctl
    tectonic
    nix-index
    (uutils-coreutils.override {prefix = "";})
  ];
}
