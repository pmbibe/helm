{{/*
Expand the name of the chart.
*/}}
{{- define "pmbibe-registry.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "pmbibe-registry.fullname" -}}
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
{{- define "pmbibe-registry.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Namespace
*/}}
{{- define "pmbibe-registry.namespace" -}}
{{- if  eq .Release.Namespace "default" -}}
{{- printf "%s-%s" .Values.environtment .Values.name }}
{{- else -}}
{{- .Release.Namespace -}}
{{- end }}
{{- end }}


{{/*
Common labels
*/}}
{{- define "pmbibe-registry.labels" -}}
helm.sh/chart: {{ include "pmbibe-registry.chart" . }}
{{ include "pmbibe-registry.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- if .Values.additionalLabels }}
{{ toYaml .Values.additionalLabels }}
{{- end }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "pmbibe-registry.selectorLabels" -}}
app.kubernetes.io/name: {{ include "pmbibe-registry.name" . }}
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

{{- define "pmbibe-registry.deployment.apiVersion" -}}
{{- print "apps/v1" -}}
{{- end -}}

{{- define "pmbibe-registry.imageStream.apiVersion" -}}
{{- print "image.openshift.io/v1" -}}
{{- end -}}

{{- define "pmbibe-registry.route.apiVersion" -}}
{{- print "route.openshift.io/v1" -}}
{{- end -}}

{{- define "pmbibe-registry.service.apiVersion" -}}
{{- print "v1" -}}
{{- end -}}