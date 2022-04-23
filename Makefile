scen ?= default

.PHONY: $(mol) galaxy-install pre-commit list tag

# molecule
mol = create converge verify destroy test login prepare
$(mol):
	molecule $@ -s $(scen)

list:
	molecule list

galaxy-install:
	ansible-galaxy install -f -r requirements.yml

pre-commit:
	pre-commit run --all-files

tag:
	$(eval VER=$(shell ./bin/inc_version galaxy.yml $(c)))
	git add galaxy.yml && git commit -m "chore: update to version $(VER)"
	git tag -a $(VER)
