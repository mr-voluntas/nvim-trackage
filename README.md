# nvim-trackage 

A little plugin which records how long you use particular file types / languages.

[track] + langu[age] = trackage

![License](https://img.shields.io/github/license/mr-voluntas/nvim-trackage)
![Neovim Version](https://img.shields.io/badge/Neovim-0.8%2B-blue)

---

## 🚀 Features

- ✅ Tracks the time you spend using different file types & languages.
- ✅ Starts recording upon entering the buffer, stops when leaving it.
- ✅ Provides a floating window to display the metrics in hours/mins/seconds format.
- ✅ Data is stored within a JSON file.


Example floating window contents
```txt
json: 3 hours 34 mins 10 seconds
md: 1 hour 57 mins 29 seconds
go: 2 hours 17 mins 56 seconds
txt: 41 mins 19 seconds
lua: 2 hours 47 mins 50 seconds
java: 68 hours 46 mins 40 seconds
```

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

### Using Packer
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

- `:OpenTrackage` → Opens the floating window displaying trackage info. 


### Keybindings

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


