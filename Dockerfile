FROM maven:3-jdk-7

ARG SWAGGER_CODEGEN_DIR=/opt/swagger-codegen-prebuilt
ARG SWAGGER_CODEGEN_CLI=$SWAGGER_CODEGEN_DIR/modules/swagger-codegen-cli/target/swagger-codegen-cli.jar

RUN git clone -b v2.2.1 https://github.com/swagger-api/swagger-codegen $SWAGGER_CODEGEN_DIR \
 && cd $SWAGGER_CODEGEN_DIR \
 && mvn package \
 && printf '#!/bin/bash\njava -jar $SWAGGER_CODEGEN_CLI $@\n' > /bin/swagger-codegen \
 && chmod a+x /bin/swagger-codegen

WORKDIR /src
VOLUME  /src

ENTRYPOINT ["swagger-codegen"]

CMD ["help"]
