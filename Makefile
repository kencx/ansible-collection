scen ?= default

.PHONY: $(mol) galaxy-install pre-commit

# molecule
mol = create converge verify destroy test
$(mol):
	molecule $@ -s $(scen)

# playbook
# inventory:
# 	ansible-inventory --graph -i $(inv)
#
# run:
# 	ansible-playbook "$(playbook).yml" -K
#
# dry-run:
# 	ansible-playbook --check "$(playbook).yml" -K

# galaxy
galaxy-install:
	ansible-galaxy install -f -r requirements.yml

pre-commit:
	pre-commit run --all-files
