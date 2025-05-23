{{/*
Common labels for resources
*/}}
{{- define "metrics-app.labels" -}}
app: {{ .Chart.Name }}
release: {{ .Release.Name }}
{{- end -}}

{{/*
Common annotations for resources
*/}}
{{- define "metrics-app.annotations" -}}
{{- if .Values.annotations }}
{{ toYaml .Values.annotations | nindent 4 }}
{{- end }}
{{- end -}}

{{/*
Generate the full name of the resource
*/}}
{{- define "metrics-app.fullname" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}