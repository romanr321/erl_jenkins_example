# Build stage 0
FROM erlang:24-alpine

# Set working directory
RUN mkdir /buildroot
WORKDIR /buildroot

# Copy our Erlang test application
COPY . erl_jenkins_example

# And build the release
WORKDIR erl_jenkins_example
RUN rebar3 upgrade --all
RUN rebar3 as prod release

# Build stage 1
FROM alpine

# Install some libs
RUN apk update && \
    
    apk add --no-cache openssl && \
    apk add --no-cache ncurses-libs && \
    apk add --no-cache libstdc++

# Install the released application
COPY --from=0 /buildroot/erl_jenkins_example/_build/prod/rel/erl_jenkins_example /erl_jenkins_example

# Expose relevant ports
EXPOSE 8080

CMD ["/erl_jenkins_example/bin/erl_jenkins_example", "foreground"]