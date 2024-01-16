{
  plugins.telescope = {
    enable = true;

    defaults = {
      file_ignore_patterns = [
	"node_modules/.*"
	"%.pem"
	".git/.*"
      ];
    };

    extensions = {
      file_browser.enable = true;
      fzf-native.enable = true;
    };

    keymaps = {
      "<leader>sg" = {
        action = "live_grep";
        desc = "Search by Grep";
      };
      "<leader>sf" = {
        action = "find_files";
        desc = "Find Files";
      };
      "<leader><space>" = {
	action = "buffers";
	desc = "Find Buffers";
      };
      "<leader>sh>" = {
	action = "help_tags";
	desc = "Search Help";
      };
      "<leader>sw" = {
	action = "grep_string";
	desc = "Search Current Word";
      };
    };
  };
}
