SHELL := /bin/bash

.PHONY: setup test lint fmt verify run

setup:
	./scripts/doctor.sh

fmt:
	@echo "No formatter configured by default. Install swiftformat to enable formatting."

lint:
	./scripts/lint.sh

test:
	swift test

verify:
	./scripts/verify.sh

run:
	swift run multitasking-demo
