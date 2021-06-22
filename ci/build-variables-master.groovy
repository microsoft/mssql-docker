AWS_ACCOUNT_ID_DEPLOY="465728785746"
AWS_REGION_DEPLOY="us-east-1"
AWS_ECR_CONFIGS=[
        ["ECR_REGISTRY":"https://"+AWS_ACCOUNT_ID_DEPLOY+".dkr.ecr."+AWS_REGION_DEPLOY+".amazonaws.com", "LOCAL_TAG":"microsoft/mssql-server-windows-developer:2017-GA-servercore-1809-amd64", "REMOTE_TAG":AWS_ACCOUNT_ID_DEPLOY+".dkr.ecr."+AWS_REGION_DEPLOY+".amazonaws.com/microsoft/mssql-server-windows-developer:2017-GA-servercore-1809-amd64"]
]
GCHAT_CREDENTIALS_ID="gchat-dsp-team-cicd"
GIT_REPO_URL="https://github.com/thegaleogroup/mssql-docker"

return this