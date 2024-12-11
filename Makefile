# Makefile for Server Setup and Deployment 🚀

# Variables
ANSIBLE_PLAYBOOK = ansible-playbook
INVENTORY = ansible/inventory.yml
PLAYBOOKS_DIR = ansible/playbooks

.PHONY: all setup docker swarm

all: setup docker swarm ## 🛠️ Run the complete setup process

setup: ## 🔒 Perform server hardening and create the user
	@echo "🔧 Starting server hardening and user creation..."
	$(ANSIBLE_PLAYBOOK) -i $(INVENTORY) $(PLAYBOOKS_DIR)/setup.yml

docker: ## 🐳 Install Docker and configure it
	@echo "📦 Installing Docker on all nodes..."
	$(ANSIBLE_PLAYBOOK) -i $(INVENTORY) $(PLAYBOOKS_DIR)/docker.yml

swarm: ## 🐝 Set up Docker Swarm and deploy Portainer-EE
	@echo "🌐 Configuring Docker Swarm and deploying Portainer-EE..."
	$(ANSIBLE_PLAYBOOK) -i $(INVENTORY) $(PLAYBOOKS_DIR)/swarm.yml

help: ## ℹ️ Show help message
	@echo "Usage: make [target]"
	@echo
	@echo "Targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = "##"}; {printf "  %-10s %s\n", $$1, $$2}'
