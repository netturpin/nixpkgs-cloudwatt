{ nixpkgs ? <nixpkgs> }:

let bootstrap_pkgs = import nixpkgs {};
in {
  pkgs = bootstrap_pkgs.fetchFromGitHub {
    owner = "nlewo";
    repo = "nixpkgs";
    # Belong to the branch release-17.09-cloudwatt
    rev = "0c41433868ad61aac43da184c113f305a3784957";
    sha256 = "0jrlk9wwbskzw2bxvncna1fi4qm596r83smcfh1dashb8gm3ddp8";};
  contrail = bootstrap_pkgs.fetchFromGitHub {
    owner = "nlewo";
    repo = "nixpkgs-contrail";
    # Belong to the master branch
    rev = "29ca558d4fcb331ff482cfa3b0124cba59ff86dc";
    sha256 = "1rbx9lxs47bivdrh7g18gqpj6j2317k48h6wavmfqk67r2v2kfqn";};
  }
