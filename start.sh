#!/usr/bin/env bash
poetry install

poetry run opentelemetry-bootstrap -a install

OTEL_TRACES_EXPORTER="console" \
                    OTEL_METRICS_EXPORTER="none"
                    OTEL_PROPAGATORS="tracecontext,baggage" \
                    OTEL_TRACES_SAMPLER="parentbased_traceidratio" poetry run opentelemetry-instrument \
                    --traces_exporter console \
                    --service_name otel-asgi-issue \
                    uvicorn otel_asgi_issue.app:app
