#############################################################################
## 
##   Logtalk Dockerfile
##   Last updated on May 12, 2025
## 
##   This file is part of Logtalk <https://logtalk.org/>  
##   SPDX-FileCopyrightText: 2017-2025 Paulo Moura <pmoura@logtalk.org>
##   SPDX-FileCopyrightText: 2017 Sergio Castro <sergioc78@gmail.com>
##   SPDX-License-Identifier: Apache-2.0
##   
##   Licensed under the Apache License, Version 2.0 (the "License");
##   you may not use this file except in compliance with the License.
##   You may obtain a copy of the License at
##   
##       http://www.apache.org/licenses/LICENSE-2.0
##   
##   Unless required by applicable law or agreed to in writing, software
##   distributed under the License is distributed on an "AS IS" BASIS,
##   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
##   See the License for the specific language governing permissions and
##   limitations under the License.
## 
#############################################################################


FROM swipl:stable

LABEL org.opencontainers.image.authors="pmoura@logtalk.org"

VOLUME ["/source", "/logtalkuser_prefix"]

# Logtalk environment
ENV LOGTALKHOME=/usr/local/share/logtalk
ENV LOGTALKUSER=/root/logtalk

# Preparation for downloading
ENV LOGTALK_DOWNLOAD=/download
RUN mkdir $LOGTALK_DOWNLOAD -p
WORKDIR $LOGTALK_DOWNLOAD

# Install curl
RUN apt-get update
RUN apt-get install -y curl

ARG LOGTALK_VERSION=master

# Download Logtalk
RUN curl -sL https://github.com/LogtalkDotOrg/logtalk3/archive/${LOGTALK_VERSION}.tar.gz | tar xz

# Install Logtalk
RUN $LOGTALK_DOWNLOAD/logtalk3-${LOGTALK_VERSION}/scripts/install.sh -p /usr/local
RUN logtalk_user_setup

WORKDIR /source
ENTRYPOINT ["swilgt"]
