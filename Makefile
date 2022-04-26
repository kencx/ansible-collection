scen ?= default

.PHONY: $(mol) install pre-commit list tag

install:
	ansible-galaxy install -f -r requirements.yml

pre-commit:
	pre-commit run --all-files

# molecule commands
mol = create converge verify destroy test login prepare
$(mol):
	molecule $@ -s $(scen)

list:
	molecule list

tag:
	$(eval VER=$(shell ./bin/inc_version galaxy.yml $(c)))
	git add galaxy.yml && git commit -m "chore: update to version $(VER)"
	git tag -a $(VER)


# run tests in parallel
scenarios := $(wildcard molecule/*)

.PHONY: $(scenarios)

$(scenarios):
	molecule test --parallel -s $(notdir $@)
