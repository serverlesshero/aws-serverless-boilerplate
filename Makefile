catalog-lambda:
	echo "running dotnet publish.."
	dotnet lambda package --project-location backend/lambdas/catalog --configuration release --framework net6.0 --output-package releases/catalog-latest.zip
	echo "uploading to S3.."
	aws s3 cp releases/catalog-latest.zip s3://serverlesshero-releases/lambdas/catalog-latest.zip

tf-apply:
	cd ./terraform/environments/dev/ && terraform apply