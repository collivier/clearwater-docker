FROM alpine:3.11

ARG VIMS_TEST_TAG=release-130
ARG QUAFF_TAG=59213d6d8ee29433552bb75f505cdc96b0b18909

ENV ZONE=default.svc.cluster.local
ENV PROXY=bono.default.svc.cluster.local
ENV ELLIS=ellis.default.svc.cluster.local
ENV SIGNUP_CODE=secret

RUN apk --no-cache add --update \
        ruby ruby-bundler ruby-irb ruby-rdoc libxslt libxml2 libffi && \
    apk --no-cache add --virtual .build-deps --update \
        ruby-dev git libxslt-dev libxml2-dev libffi-dev g++ make && \
    git clone --depth 1 -b $VIMS_TEST_TAG https://github.com/Metaswitch/clearwater-live-test /src/vims-test && \
    sed -i s/unf_ext\ \(.*\)/unf_ext\ \(0.0.7.4\)/g /src/vims-test/Gemfile.lock && \
    git init /src/vims-test/quaff && \
    (cd /src/vims-test/quaff && \
        git fetch --tags https://github.com/Metaswitch/quaff $QUAFF_TAG && \
        git checkout FETCH_HEAD) && \
    (cd /src/vims-test && bundle config build.nokogiri --use-system-libraries && bundle install --system && bundle update rest-client) && \
    apk del .build-deps
WORKDIR /src/vims-test
CMD rake test[$ZONE] PROXY=$PROXY ELLIS=$ELLIS SIGNUP_CODE=$SIGNUP_CODE --trace
