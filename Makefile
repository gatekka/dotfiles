# List of directories to stow.
STOW_DIRS = zsh kitty nvim

# Stow the directories with confirmation
stow:
	@echo "Simulating stow operation for directories: $(STOW_DIRS)"
	@stow -n --verbose $(STOW_DIRS)  # Dry-run
	@read -p "Proceed with stow and modify filesystem? (y/n): " choice; \
	if [ $$choice = "y" ]; then \
		stow $(STOW_DIRS); \
	else \
		echo "Stow canceled."; \
	fi

# Remove stowed directories
stow-delete:
	@echo "Simulating stow-delete operation for directories: $(STOW_DIRS)"
	@stow -n --verbose --delete $(STOW_DIRS)  # Dry-run
	@read -p "Proceed with stow-delete and modify filesystem? (y/n): " choice; \
	if [ $$choice = "y" ]; then \
		stow --delete $(STOW_DIRS); \
	else \
		echo "Stow-delete canceled."; \
	fi
