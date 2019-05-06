FROM oracle/graalvm-ce:1.0.0-rc16 AS build
WORKDIR /graalvm-java-native-example
ADD target/graalvm-java-native-example-1.0-SNAPSHOT.jar .
RUN jar -xvf graalvm-java-native-example-1.0-SNAPSHOT.jar; \
    native-image -H:+ReportUnsupportedElementsAtRuntime --allow-incomplete-classpath --report-unsupported-elements-at-runtime -Dfile.encoding=UTF-8 -cp . com.mvinuesa.graalvm.GraalVMJavaNativeExample; \
    ls -la; \
    echo "shell used"; \
    echo $0; \
    ./com.mvinuesa.graalvm.graalvmjavanativeexample

FROM frolvlad/alpine-glibc:alpine-3.8_glibc-2.28
WORKDIR /graalvm-java-native-example
COPY --from=build /graalvm-java-native-example/com.mvinuesa.graalvm.graalvmjavanativeexample ./example
RUN ls -la; \
    echo "shell used"; \
    echo $0; \
    ./example
CMD ./example