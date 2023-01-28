echo "Authorizing GitHub"
gh auth login --hostname github.ibm.com
echo "Authorized GitHub"
template=$(git remote get-url --push origin)

echo "Enter the name of the repository: "
read nameOfRepo

gh repo create LUIS-AYALA/${nameOfRepo} --template="${template}" --public
echo "Succesfully initialized ${nameOfRepo}"
cd ../
echo "root folder"
echo "Cloning Repo ${nameOfRepo}"
sleep 10
gh repo clone LUIS-AYALA/${nameOfRepo} ${nameOfRepo}
returnCode=$?
if [ "${returnCode}" != "0" ]; then
    echo "GH failed"
    exit 1
fi
echo "Repo Cloned"
cd ${nameOfRepo}
tmp=$(mktemp)

repo=$(git remote get-url --push origin)

sed -i '' "/sonar.projectKey=/ s/=.*/=${nameOfRepo}/" sonar-project.properties
returnCode=$?
if [ "${returnCode}" != "0" ]; then
    echo "Sed failed"
    exit 1
fi
sed -i '' "/sonar.projectName=/ s/=.*/=${nameOfRepo}/" sonar-project.properties
returnCode=$?
if [ "${returnCode}" != "0" ]; then
    echo "Sed failed"
    exit 1
fi
echo "Sonar properties file updated project key and name with value ${nameOfRepo}"

jq '.name = "'${nameOfRepo}'"' package.json > "$tmp" && mv "$tmp" package.json
jq '.description = "'${nameOfRepo}'"' package.json > "$tmp" && mv "$tmp" package.json
echo "Package.json file updated name and description with value ${nameOfRepo}"
jq '.repository.url = "git+'${repo}'"' package.json > "$tmp" && mv "$tmp" package.json
jq '.bugs.url = "https://github.com/LUIS-AYALA/'${nameOfRepo}'/issues"' package.json > "$tmp" && mv "$tmp" package.json
jq '.homepage = "https://github.com/LUIS-AYALA/'${nameOfRepo}'#readme"' package.json > "$tmp" && mv "$tmp" package.json
echo "Package.json file updated relevant urls with value ${nameOfRepo}"

#nvm use
npm install
git add .
git commit -m "feat: update project config files"
git push
npx snyk monitor
npm run sonarcloud
echo "Repo URL: ${repo}"
echo "Opening project in Visual Studio"
code .