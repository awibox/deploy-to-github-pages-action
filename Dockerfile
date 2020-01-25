FROM alpine:3.10

LABEL "com.github.actions.name"="Deploy your app to GitHub Pages"
LABEL "com.github.actions.description"="GitHub action that will help deploy your app to the repository for GitHub Pages"
LABEL "com.github.actions.icon"="download"
LABEL "com.github.actions.color"="yellow"

LABEL "repository"="https://github.com/awibox/deploy-to-github-pages-action"
LABEL "homepage"="https://github.com/awibox/deploy-to-github-pages-action#readme"
LABEL "maintainer"="Andrei Arkhipov <andrei@awb.pw>"
LABEL "version"="1.1.1"

RUN apk add --no-cache git

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
