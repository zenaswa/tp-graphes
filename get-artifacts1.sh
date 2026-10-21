tok=$(cat token.gh)

curl -L \
	-H "Accept: application/vnd.github+json" \
	-H "Authorization: Bearer $tok" \
	-H "X-GitHub-Api-Version: 2026-03-10" \
	https://api.github.com/repos/zenaswa/tp-graphes/actions/artifacts \
	 > gh-artifacts.json

jq '.artifacts[].id' gh-artifacts.json > liste-id.txt

for id in $(cat liste-id.txt);
do
	curl -L \
		-H "Accept: application/vnd.github+json" \
		-H "Authorization: Bearer $tok" \
		-H "X-GitHub-Api-Version: 2026-03-10" \
		https://api.github.com/repos/zenaswa/tp-graphes/actions/artifacts/$id/zip \
		--output artifact-$id.zip
	unzip artifact-$id.zip
done


