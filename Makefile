.PHONY: install uninstall list help check

# Default Claude skills directory locations (in order of preference)
CLAUDE_HOME := $(HOME)/.claude
CLAUDE_CONFIG := $(HOME)/.config/claude
CLAUDE_SKILLS_DIR := $(CLAUDE_HOME)/skills
CLAUDE_CONFIG_SKILLS := $(CLAUDE_CONFIG)/skills

# Detect which directory exists or create the default
SKILLS_DIR := $(shell \
	if [ -d "$(CLAUDE_SKILLS_DIR)" ]; then \
		echo "$(CLAUDE_SKILLS_DIR)"; \
	elif [ -d "$(CLAUDE_CONFIG_SKILLS)" ]; then \
		echo "$(CLAUDE_CONFIG_SKILLS)"; \
	elif [ -d "$(CLAUDE_HOME)" ]; then \
		echo "$(CLAUDE_SKILLS_DIR)"; \
	elif [ -d "$(CLAUDE_CONFIG)" ]; then \
		echo "$(CLAUDE_CONFIG_SKILLS)"; \
	else \
		echo "$(CLAUDE_SKILLS_DIR)"; \
	fi)

# Source directory (this repository)
SOURCE_DIR := $(shell pwd)
SKILLS_SOURCE := $(SOURCE_DIR)/skills

# Colors for output
GREEN := \033[0;32m
YELLOW := \033[1;33m
RED := \033[0;31m
NC := \033[0m # No Color

help: ## Show this help message
	@echo "$(GREEN)Skills Installation$(NC)"
	@echo ""
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  $(GREEN)%-15s$(NC) %s\n", $$1, $$2}'
	@echo ""
	@echo "Skills directory: $(SKILLS_DIR)"
	@echo "Source directory: $(SOURCE_DIR)"

check: ## Check if skills directory exists and show current setup
	@echo "$(YELLOW)Checking Claude skills setup...$(NC)"
	@echo ""
	@if [ -d "$(SKILLS_DIR)" ]; then \
		echo "$(GREEN)✓$(NC) Skills directory exists: $(SKILLS_DIR)"; \
		echo ""; \
		echo "Installed skills:"; \
		ls -1 "$(SKILLS_DIR)" 2>/dev/null | sed 's/^/  - /' || echo "  (none)"; \
	else \
		echo "$(RED)✗$(NC) Skills directory does not exist: $(SKILLS_DIR)"; \
		echo ""; \
		echo "$(YELLOW)Note:$(NC) The directory will be created during installation."; \
	fi
	@echo ""
	@echo "Available skills in repository:"
	@ls -1 "$(SKILLS_SOURCE)" 2>/dev/null | sed 's/^/  - /' || echo "  (none found)"

install: ## Install all skills to Claude skills directory
	@echo "$(GREEN)Installing Skills...$(NC)"
	@echo ""
	@# Create skills directory if it doesn't exist
	@mkdir -p "$(SKILLS_DIR)"
	@echo "$(GREEN)✓$(NC) Skills directory: $(SKILLS_DIR)"
	@echo ""
	@# Install each skill
	@if [ ! -d "$(SKILLS_SOURCE)" ]; then \
		echo "$(RED)✗$(NC) Skills source directory not found: $(SKILLS_SOURCE)"; \
		exit 1; \
	fi
	@for skill in $$(ls -1 "$(SKILLS_SOURCE)" 2>/dev/null); do \
		skill_source="$(SKILLS_SOURCE)/$$skill"; \
		skill_target="$(SKILLS_DIR)/$$skill"; \
		if [ -d "$$skill_source" ] && [ -f "$$skill_source/SKILL.md" ]; then \
			if [ -e "$$skill_target" ]; then \
				echo "$(YELLOW)⚠$(NC) Skill '$$skill' already exists, skipping..."; \
			else \
				ln -sf "$$skill_source" "$$skill_target" 2>/dev/null || \
				cp -r "$$skill_source" "$$skill_target"; \
				if [ -L "$$skill_target" ]; then \
					echo "$(GREEN)✓$(NC) Installed '$$skill' (symlink)"; \
				else \
					echo "$(GREEN)✓$(NC) Installed '$$skill' (copy)"; \
				fi; \
			fi; \
		fi; \
	done
	@echo ""
	@echo "$(GREEN)Installation complete!$(NC)"
	@echo ""
	@echo "Installed skills:"
	@ls -1 "$(SKILLS_DIR)" 2>/dev/null | sed 's/^/  - /' || echo "  (none)"
	@echo ""
	@echo "$(YELLOW)Note:$(NC) If you're using Claude Desktop, you may need to restart it"
	@echo "      for the skills to be recognized."

uninstall: ## Remove all installed skills
	@echo "$(YELLOW)UninstallingSkills...$(NC)"
	@echo ""
	@if [ ! -d "$(SKILLS_DIR)" ]; then \
		echo "$(RED)✗$(NC) Skills directory does not exist: $(SKILLS_DIR)"; \
		exit 1; \
	fi
	@for skill in $$(ls -1 "$(SKILLS_SOURCE)" 2>/dev/null); do \
		skill_target="$(SKILLS_DIR)/$$skill"; \
		if [ -e "$$skill_target" ]; then \
			rm -rf "$$skill_target"; \
			echo "$(GREEN)✓$(NC) Removed '$$skill'"; \
		fi; \
	done
	@echo ""
	@echo "$(GREEN)Uninstallation complete!$(NC)"

list: ## List all available skills in the repository
	@echo "$(GREEN)Available Skills:$(NC)"
	@echo ""
	@if [ ! -d "$(SKILLS_SOURCE)" ]; then \
		echo "$(RED)✗$(NC) Skills source directory not found"; \
		exit 1; \
	fi
	@for skill in $$(ls -1 "$(SKILLS_SOURCE)" 2>/dev/null); do \
		skill_path="$(SKILLS_SOURCE)/$$skill"; \
		if [ -d "$$skill_path" ] && [ -f "$$skill_path/SKILL.md" ]; then \
			skill_name=$$(grep -E '^name:' "$$skill_path/SKILL.md" | head -1 | sed 's/^name: *//' || echo "$$skill"); \
			skill_desc=$$(grep -E '^description:' "$$skill_path/SKILL.md" | head -1 | sed 's/^description: *//' || echo "No description"); \
			echo "  $(GREEN)$$skill$(NC)"; \
			echo "    Name: $$skill_name"; \
			echo "    Description: $$skill_desc"; \
			echo ""; \
		fi; \
	done

update: ## Update installed skills (reinstall)
	@echo "$(YELLOW)Updating Skills...$(NC)"
	@$(MAKE) uninstall
	@$(MAKE) install

