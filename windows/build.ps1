pushd $PSScriptRoot

Get-ChildItem -Recurse -Filter dockerfile | foreach {
	$tag = $_.Directory.Name
	docker build -t $tag $_.DirectoryName
}

popd