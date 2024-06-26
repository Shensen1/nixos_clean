# shell.nix
{ pkgs ? import <nixpkgs> {} }:

let
  myPython = pkgs.python312;
  pythonPackages = pkgs.python312Packages;

  pythonWithPkgs = myPython.withPackages (pythonPkgs: with pythonPkgs; [
    # This list contains tools for Python development.
    # You can also add other tools, like black.
    #
    # Note that even if you add Python packages here like PyTorch or Tensorflow,
    # they will be reinstalled when running `pip -r requirements.txt` because
    # virtualenv is used below in the shellHook.
    ipython
    pip
    setuptools
    virtualenvwrapper
    wheel
    black
  ]);

  extraBuildInputs = with pkgs; [
    # this list contains packages that you want to be available at runtime and might not be able to be installed properly via pip
    # pythonPackages.pandas
    # pythonPackages.requests
  ];
in
import ./python-shell.nix { 
    extraBuildInputs=extraBuildInputs; 
    extraLibPackages=extraLibPackages; 
    myPython=myPython;
    pythonWithPkgs=pythonWithPkgs;
}
