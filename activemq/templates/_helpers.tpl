{{/*
Return the appropriate apiVersion for deployment.
*/}}
{{- define "activemq.deployment.apiVersion" -}}
{{- print "apps/v1" -}}
{{- end -}}

{{/*
Return the appropriate apiVersion for Image Stream.
*/}}
{{- define "activemq.imagestream.apiVersion" -}}
{{- print "image.openshift.io/v1" -}}
{{- end -}}

{{/*

*/}}

{{- define "activemq.route.apiVersion" -}}
{{- print "route.openshift.io/v1" -}}
{{- end -}}

{{/*

*/}}

{{- define "activemq.service.apiVersion" -}}
{{- print "v1" -}}
{{- end -}}

{{/*

*/}}

{{- define "activemq.labels" -}}
{{- print "app: apache-activemq" -}}
{{- end -}}

{{/*
Define the activemq.namespace template if set with forceNamespace or .Release.Namespace is set
*/}}
{{- define "activemq.namespace" -}}
{{- if not .Values.forceNamespace -}}
{{ printf "%s-%s" .Values.environment .Values.name}}
{{- else -}}
{{- default .Release.Namespace .Values.forceNamespace -}}
{{- end }}
{{- end }}

{{/*
Create a fully qualified activemq server name.
*/}}
{{- define "activemq.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- printf "%s-%s" .Values.name .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Values.name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}
