FROM alpine:3.10

LABEL "com.github.actions.name"="Deploy your app to GitHub Pages"
LABEL "com.github.actions.description"="Deployment build files to your main repository for Github Pages"
LABEL "com.github.actions.icon"="upload"
LABEL "com.github.actions.color"="blue"

LABEL "repository"="https://github.com/awibox/deploy-to-github-pages-action"
LABEL "homepage"="https://github.com/awibox/deploy-to-github-pages-action#readme"
LABEL "maintainer"="Andrei Arkhipov <andrei@awb.pw>"
LABEL "version"="1.0.0"

RUN apk add --no-cache git

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
