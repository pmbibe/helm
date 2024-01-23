{{- define "pmbibe-edge.deployment.apiVersion" -}}
{{- print "apps/v1" -}}
{{- end -}}

{{- define "pmbibe-edge.imageStream.apiVersion" -}}
{{- print "image.openshift.io/v1" -}}
{{- end -}}

{{- define "pmbibe-edge.route.apiVersion" -}}
{{- print "route.openshift.io/v1" -}}
{{- end -}}

{{- define "pmbibe-edge.service.apiVersion" -}}
{{- print "v1" -}}
{{- end -}}

{{- define "pmbibe-edge.labels" -}}
{{- print "app: pmbibe-edge-pmbibe" -}}
{{- end -}}

{{- define "pmbibe-edge.fullName" -}}
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

{{/* 

*/}}

{{- define "pmbibe-edge.namespace" -}}
{{- if .Values.forceNamespace -}}
{{- default .Release.Namespace .Values.forceNamespace -}}
{{- else -}}
{{- printf "%s-%s" .Values.environment .Values.name -}}
{{- end -}}
{{- end -}}


{{/*

*/}}

{{- define "pmbibe-edge.volumes" -}}
{{- range $volume := .Values.volumes }}
{{ print "- " | indent 4 -}}
{{- printf "name: %s" $volume.name }}
{{- toYaml $volume.data | nindent 6 }}
{{- end }}
{{- end -}}

