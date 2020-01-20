## Description
You can use GitHub Pages like hosting for your project. 
To do this, you need to create a repository and activate GitHub Pages for the master branch and bind your domain.
Then use this action to help you set up automatic deployment from your app to your repository for GitHub Pages.

## Getting started
You should create deploy.yml file using the example below:
```
name: Deploy to GitHub Pages
on:
  push:
    branches:
      - master
jobs:
  deploy:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        node-version: [13.2.0]
    steps:
      - uses: actions/checkout@master
      - name: install, build, and test
        run: |
          yarn install
          yarn lint
          yarn build
          yarn test
        env:
          CI: true
      - name: Deploy to production
        uses: awibox/deploy-to-github-pages-action@1.1.0
        env:
          AUTHOR: awibox
          BUILD_PATH: public
          GITHUB_PAGE_NAME: awibox.github.io
          PA_TOKEN: ${{ secrets.PA_TOKEN }}
          USERNAME: awibox
          EMAIL: andrei@awb.pw
```

## Environment variables
|Environment variable|Required|Description|Example|
|--------------------|--------|-----------|-------|
|`AUTHOR`|Required|Name of the repository owner|awibox|
|`BUILD_PATH`|Required|The directory where the static is built| public
|`GITHUB_PAGE_NAME`|Required|Name of the repository for GitHub Pages where the application will be collected|awibox.github.io|
|`PA_TOKEN`|Required|GitHub Private Access Token with editing rights for repo. You can create it using [GitHub Documentation](https://help.github.com/en/articles/creating-a-personal-access-token-for-the-command-line)|${{secrets.PA_TOKEN}}|
|`USERNAME`|Optional|The GitHub username for commits.|awibox|
|`EMAIL`|Optional|The email that is used for commits.|andrei@awb.pw|

