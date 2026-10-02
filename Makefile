export HEADROOM_TELEMETRY := off

.PHONY: build test run down clean optional-build optional-test optional-benchmark aider

IMAGE := meshlib-migration-assessment

build:
	docker build --target build -t $(IMAGE):build .

test:
	docker build --target test -t $(IMAGE):test .

optional-build:
	docker build --target optional-build -t collision-benchmark:build .

optional-test:
	docker build --target optional-test -t collision-benchmark:test .

optional-benchmark: optional-build
	docker run --rm collision-benchmark:build collision-benchmark

run:
	docker compose up --build

down:
	docker compose down

clean:
	docker compose down --rmi local --volumes --remove-orphans

aider:
	headroom wrap aider --watch-files --config .aider.conf.yml
