# nvim-trackage 

A little plugin which records how long you use particular file types / languages.

[track] + langu[age] = trackage

![License](https://img.shields.io/github/license/mr-voluntas/nvim-trackage)
![Neovim Version](https://img.shields.io/badge/Neovim-0.8%2B-blue)

---

## 🚀 Features

- ✅ Records the time you spend inside a buffer for each file type / language.
- ✅ Stops / starts the timer when jumping between buffers.
- ✅ Very basic floating window which displays the file type / language and usage time.

---

## 📦 Installation

### Using Lazy.nvim
```lua
return {
	"mr-voluntas/nvim-trackage",
	config = function()
		require("nvim-trackage").setup({ time_record_file = "./time_record_file.json" })
	end,
}
```

### Using Packer (Optional)
```lua
use {
	"mr-voluntas/nvim-trackage",
    config = function()
		require("nvim-trackage").setup({ time_record_file = "./time_record_file.json" })
    end
}
```

---

## ⚙️ Configuration

Customise the trackage file location, defaults to "./trackage.json"

```lua
require("nvim-trackage").setup({ time_record_file = "./trackage.json" })
```

---

## 🎯 Usage

### Basic Commands

- `:OpenTrackage` → Opens the floating window displaying trackage info

### Keybindings (Optional)

You can add this to your Neovim configuration:

```lua
vim.keymap.set("n", "<leader>ot", vim.cmd.OpenTrackage, { desc = "show trackage data", silent = true})
```

---

## 📜 API

### :OpenTrackage
Opens the floating window displaying trackage data

---

## 🛠️ Contributing

1. Fork the repository.
2. Create a new branch: `git checkout -b feature-name`
3. Commit your changes: `git commit -m "Add new feature"`
4. Push to your branch: `git push origin feature-name`
5. Open a **Pull Request** 🎉

---

## 📜 License

This plugin is licensed under the [MIT License](LICENSE).


