{{/*
Expand the name of the chart.
*/}}
{{- define "babibe.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "babibe.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "babibe.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}


{{/*
Namespace
*/}}
{{- define "babibe.namespace" -}}
{{- if  eq .Release.Namespace "default" -}}
{{- printf "%s-%s" .Values.environtment .Values.name }}
{{- else -}}
{{- .Release.Namespace -}}
{{- end }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "babibe.labels" -}}
helm.sh/chart: {{ include "babibe.chart" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{ include "babibe.selectorLabels" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "babibe.selectorLabels" -}}
app.kubernetes.io/name: {{ include "babibe.name" . }}
{{- if not (eq .Release.Name "release-name") }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- else -}}
{{- $instance := printf "%s" .Values.name }}
app.kubernetes.io/instance: {{ $instance }}
{{- end -}}
{{- end }}

{{/*
apiVersion
*/}}

{{- define "babibe.deployment.apiVersion" -}}
{{- print "apps/v1" }}
{{- end -}}

{{- define "babibe.imageStream.apiVersion" -}}
{{- print "image.openshift.io/v1" -}}
{{- end -}}

{{- define "babibe.ingress.apiVersion" -}}
{{- print "networking.k8s.io/v1beta1" -}}
{{- end -}}

{{- define "babibe.route.apiVersion" -}}
{{- print "route.openshift.io/v1" -}}
{{- end -}}

{{- define "babibe.service.apiVersion" -}}
{{- print "v1" -}}
{{- end -}}
