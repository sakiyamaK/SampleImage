setup:
	./script/setup.sh
	open SampleImage.xcworkspace
.PHONY: setup

clean:
	./script/clean.sh
.PHONY: clean

component:
	mint run pui component VIPER ${name}
.PHONY: clean
