CONTEXT = microsoft
VERSION = v14.0
IMAGE_NAME = mssql-server-linux
TARGET = centos7
REGISTRY = docker-registry.default.svc.cluster.local
OC_USER = developer
OC_PASS = developer
MSSQL_SA_PASSWORD = yourStrong@Password

all: build
build:
	docker build --pull -t ${CONTEXT}/${IMAGE_NAME}:${TARGET}-${VERSION} -t ${CONTEXT}/${IMAGE_NAME} .
	@if docker images ${CONTEXT}/${IMAGE_NAME}:${TARGET}-${VERSION}; then touch build; fi

lint:
	dockerfile_lint -f Dockerfile

test:
	$(eval CONTAINERID=$(shell docker run -e ACCEPT_EULA=Y -e MSSQL_SA_PASSWORD=${MSSQL_SA_PASSWORD} -d ${CONTEXT}/${IMAGE_NAME}:${TARGET}-${VERSION}))
	@sleep 2
	@docker exec ${CONTAINERID} ps aux
	@sleep 20
	@docker exec ${CONTAINERID} sqlcmd -S localhost -U SA -P ${MSSQL_SA_PASSWORD} -Q "sp_databases"
	@docker rm -f ${CONTAINERID}

run:
	docker run -e ACCEPT_EULA=Y -e MSSQL_SA_PASSWORD=${MSSQL_SA_PASSWORD} -p 1433:1433 -d ${CONTEXT}/${IMAGE_NAME}:${TARGET}-${VERSION}

clean:
	rm -f build