FROM mcr.microsoft.com/dotnet/core/sdk:3.1-buster AS build

# Install locale support
RUN apt-get update \
        && apt-get install -y --no-install-recommends \
        apt-transport-https \
        && apt-get update \
        && apt-get install -y --no-install-recommends locales \
        && rm -rf /var/lib/apt/lists/*

# Enable en_us.UTF-8 in /etc/locale.gen
RUN sed -i 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && locale-gen

# Set locale to UTF-8
ENV LC_ALL=en_US.UTF-8

# Install Azure Artifacts credential provider
RUN curl -o installcredprovider.sh https://raw.githubusercontent.com/Microsoft/artifacts-credprovider/master/helpers/installcredprovider.sh
RUN sh installcredprovider.sh