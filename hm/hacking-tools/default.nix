{ lib, config, pkgs, ... }:
{
  home.packages = with pkgs; [
    nmap
    gobuster
    dirb
    ffuf
    wfuzz
    wpscan
    whatweb
    thc-hydra
    burpsuite
    hashcat
    john
    bloodhound-py
    netexec
    ghidra
    metasploit
    amass
    evil-winrm
    responder
    dnsrecon
    theharvester
    bloodhound
    sqlmap
    netcat-gnu
    aircrack-ng
    openvpn
    hash-identifier
    hashid
    powershell

    wordlists

    python312Packages.impacket
    python312Packages.scapy
  ];
}
