{{/*
gateway fullname
*/}}
{{- define "loki.gatewayFullname" -}}
{{ include "loki.name" . }}-gateway
{{- end }}

{{/*
gateway common labels
*/}}
{{- define "loki.gatewayLabels" -}}
{{ include "loki.labels" . }}
app.kubernetes.io/component: gateway
{{- end }}

{{/*
gateway ingress labels
*/}}
{{- define "loki.gatewayIngressLabels" -}}
{{ include "loki.gatewayLabels" . }}
{{- toYaml .Values.gateway.ingress.labels | nindent 0 -}}
{{- end }}

{{/*
gateway selector labels
*/}}
{{- define "loki.gatewaySelectorLabels" -}}
{{ include "loki.selectorLabels" . }}
app.kubernetes.io/component: gateway
{{- end }}

{{/*
gateway auth secret name
*/}}
{{- define "loki.gatewayAuthSecret" -}}
{{ .Values.gateway.basicAuth.existingSecret | default (include "loki.gatewayFullname" . ) }}
{{- end }}

{{/*
gateway Docker image
*/}}
{{- define "loki.gatewayImage" -}}
{{- $dict := dict "service" .Values.gateway.image "global" .Values.global.image -}}
{{- include "loki.baseImage" $dict -}}
{{- end }}

{{/*
gateway priority class name
*/}}
{{- define "loki.gatewayPriorityClassName" -}}
{{- $pcn := coalesce .Values.global.priorityClassName .Values.gateway.priorityClassName -}}
{{- if $pcn }}
priorityClassName: {{ $pcn }}
{{- end }}
{{- end }}
