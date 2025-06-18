{
  pkgs,
  lib,
  config,
  ...
}:

{
  options.pi.nvim.plugins.lsp.intelephense.enable = lib.mkEnableOption "Enable Intelephense LSP";

  config = lib.mkIf config.pi.nvim.plugins.lsp.intelephense.enable {
    users.users.ls.packages = with pkgs; [
      intelephense
    ];
    home-manager.users.ls = {
      programs.nixvim.plugins.lsp = {
        servers = {
          intelephense = {
            enable = true;
            package = null;
            settings = {
              intelephense = {
                stubs = [
                  "apache"
                  "bcmath"
                  "bz2"
                  "calendar"
                  "com_dotnet"
                  "Core"
                  "ctype"
                  "curl"
                  "date"
                  "dba"
                  "dom"
                  "ds"
                  "enchant"
                  "exif"
                  "FFI"
                  "fileinfo"
                  "filter"
                  "fpm"
                  "ftp"
                  "gd"
                  "gettext"
                  "gmp"
                  "hash"
                  "iconv"
                  "imap"
                  "intl"
                  "json"
                  "ldap"
                  "libxml"
                  "mailparse"
                  "mbstring"
                  "meta"
                  "mysqli"
                  "oci8"
                  "odbc"
                  "openssl"
                  "pcntl"
                  "pcre"
                  "PDO"
                  "pdo_ibm"
                  "pdo_mysql"
                  "pdo_pgsql"
                  "pdo_sqlite"
                  "pgsql"
                  "Phar"
                  "posix"
                  "pspell"
                  "random"
                  "readline"
                  "Reflection"
                  "session"
                  "shmop"
                  "SimpleXML"
                  "snmp"
                  "soap"
                  "sockets"
                  "sodium"
                  "SPL"
                  "sqlite3"
                  "standard"
                  "superglobals"
                  "sysvmsg"
                  "sysvsem"
                  "sysvshm"
                  "tidy"
                  "tokenizer"
                  "xml"
                  "xmlreader"
                  "xmlrpc"
                  "xmlwriter"
                  "xsl"
                  "Zend OPcache"
                  "zip"
                  "zlib"
                ];

                files.maxSize = 5000000;
                format.enable = false;
                diagnostics.enable = true;
              };
            };
          };
        };
      };
    };
  };
}
