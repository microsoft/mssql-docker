CONTEXT = microsoft
VERSION = v14.0
IMAGE_NAME = mssql-server-linux
REGISTRY = docker-registry.default.svc.cluster.local
OC_USER = developer
OC_PASS = developer
SA_PASSWORD = yourStrong@Password

# Allow user to pass in OS build options
ifeq ($(TARGET),rhel7)
	DFILE := Dockerfile.${TARGET}
else
	TARGET := centos7
	DFILE := Dockerfile
endif

all: build
build:
	docker build --pull -t ${CONTEXT}/${IMAGE_NAME}:${TARGET}-${VERSION} -t ${CONTEXT}/${IMAGE_NAME} -f ${DFILE} .
	@if docker images ${CONTEXT}/${IMAGE_NAME}:${TARGET}-${VERSION}; then touch build; fi

lint:
	dockerfile_lint -f Dockerfile
	dockerfile_lint -f Dockerfile.rhel7

test:
#	$(eval CONTAINERID=$(shell docker run -e ACCEPT_EULA=Y -e SA_PASSWORD=${SA_PASSWORD} -d -u $(shell shuf -i 1000010000-1000020000 -n 1) ${CONTEXT}/${IMAGE_NAME}:${TARGET}-${VERSION}))
	$(eval CONTAINERID=$(shell docker run -e ACCEPT_EULA=Y -e SA_PASSWORD=${SA_PASSWORD} -d ${CONTEXT}/${IMAGE_NAME}:${TARGET}-${VERSION}))
	@sleep 2
	@docker exec ${CONTAINERID} ps aux
	@sleep 8
	@docker exec ${CONTAINERID} sqlcmd -S localhost -U SA -P ${SA_PASSWORD} -Q "sp_databases"
	@docker rm -f ${CONTAINERID}

openshift-test:
	$(eval PROJ_RANDOM=$(shell shuf -i 100000-999999 -n 1))
	oc login -u ${OC_USER} -p ${OC_PASS}
	oc new-project test-${PROJ_RANDOM}
	docker login -u ${OC_USER} -p ${OC_PASS} ${REGISTRY}:5000
	docker tag ${CONTEXT}/${IMAGE_NAME}:${TARGET}-${VERSION} ${REGISTRY}:5000/test-${PROJ_RANDOM}/${IMAGE_NAME}
	docker push ${REGISTRY}:5000/test-${PROJ_RANDOM}/${IMAGE_NAME}
	oc new-app -i ${IMAGE_NAME}
	oc rollout status -w dc/${IMAGE_NAME}
	oc status
	sleep 5
	oc describe pod `oc get pod --template '{{(index .items 0).metadata.name }}'`
	oc exec `oc get pod --template '{{(index .items 0).metadata.name }}'` ps aux
	oc exec `oc get pod --template '{{(index .items 0).metadata.name }}'` sqlcmd -S localhost -U SA -P '${SA_PASSWORD}'

run:
	docker run -e ACCEPT_EULA=Y -e SA_PASSWORD=${SA_PASSWORD} -p 1433:1433 \
	  -d ${CONTEXT}/${IMAGE_NAME}:${TARGET}-${VERSION}
#	  -d -u `shuf -i 1000010000-1000020000 -n 1` ${CONTEXT}/${IMAGE_NAME}:${TARGET}-${VERSION}

clean:
	rm -f build