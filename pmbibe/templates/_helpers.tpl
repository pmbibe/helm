{{- define "pmbibe.deployment.apiVersion" -}}
{{- print "apps/v1" -}}
{{- end -}}

{{- define "pmbibe.imageStream.apiVersion" -}}
{{- print "image.openshift.io/v1" -}}
{{- end -}}

{{- define "pmbibe.route.apiVersion" -}}
{{- print "route.openshift.io/v1" -}}
{{- end -}}

{{- define "pmbibe.service.apiVersion" -}}
{{- print "v1" -}}
{{- end -}}

{{- define "pmbibe.configMap.apiVersion" -}}
{{- print "v1" -}}
{{- end -}}

{{- define "pmbibe.secret.apiVersion" -}}
{{- print "v1" -}}
{{- end -}}

{{- define "pmbibe.labels" -}}
{{- print "app: pmbibe-app" -}}
{{- end -}}

{{- define "pmbibe.fullName" -}}
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

{{- define "pmbibe.namespace" -}}
{{- if .Values.forceNamespace -}}
{{- default .Release.Namespace .Values.forceNamespace -}}
{{- else -}}
{{- printf "%s-%s" .Values.environment .Values.name -}}
{{- end -}}
{{- end -}}

{{/* 

Template Container for Deployment

*/}}

{{- define "pmbibe.template.container" -}}
{{- range $container := .Values.deployment.template.containers }}
{{- print "-" -}}
{{ printf "name: %s" $container.name | indent 1 }}
{{ printf "image: %s" $container.image | indent 2 }}
{{ if $container.resources -}}
{{ printf "resources: " | indent 2 -}}
{{- toYaml $container.resources | nindent 4 -}}
{{- end -}}
{{- if $container.imagePullPolicy }}
{{ printf "imagePullPolicy: %s" $container.imagePullPolicy | indent 2 }}
{{- end }}
{{- if $container.command }}
{{ printf "command: %s" $container.command | indent 2 }}
{{- end }}
{{ printf "volumeMounts:" | indent 2 -}}
{{ range $volumeMount := $container.volumeMounts }}
{{ print "- " }}
{{- range $k, $v := $volumeMount }}
{{- printf "  %s: %s  " $k $v | nindent 2 -}}
{{- end -}}
{{ end -}}
{{ if $container.lifecycle }}
{{ print "lifecycle:" | indent 2}}
{{ toYaml $container.lifecycle | indent 4 -}}
{{ end }}
{{- if $container.env }}
{{ printf "env:" | indent 2 }}
{{ range $variable := $container.env -}}
{{ range $key, $value := $variable -}}
{{- if eq $key "name" -}}
{{ printf "- %s: %s" $key $value | indent 4 }}
{{- else -}}
{{- printf "%s:" $key | indent 6 }}
{{- toYaml $value | nindent 8 -}}
{{- end }}
{{ end }}
{{- end }}
{{- end }}
{{- if $container.startupProbe }}
{{- print "startupProbe:" | indent 2 }}
{{- toYaml $container.startupProbe | nindent 4 }}
{{- end }}
{{- if $container.args }}
{{- printf "args:" | nindent 2 }}
{{ range $arg := $container.args -}}
{{ printf "- %s" $arg | indent 4 }}
{{ end -}}
{{- end }}
{{- if $container.workingDir }}
{{- printf "workingDir: %s" $container.workingDir | indent 2 }}
{{- end }}
{{ end }}
{{- end -}}

{{/* 

deployment.hostAliases 

*/}}

{{- define "pmbibe.deployment.hostAliases" -}}
{{- if .Values.deployment.template.hostAliases -}}
{{- range $hostAliase := .Values.deployment.template.hostAliases -}}
{{ print "- " }}
{{- range $key, $value := $hostAliase }}
{{- if eq $key "ip" }}
{{ printf "ip: %s" $value | indent 2 }}
{{ else }}
{{- printf "hostname: " }}
{{- range $hostname := $value }}
{{ printf "- %s" $hostname | indent 2 }}
{{- end }}
{{- end -}} 
{{- end }}
{{- end }}
{{- end }}
{{- end -}}

{{/*

deployment.volumes

*/}}

{{- define "pmbibe.deployment.volumes" -}}
{{- if .Values.deployment.template.volumes -}}
{{- range $volume := .Values.deployment.template.volumes }}
{{ print "- " -}}
{{- range $key, $value := $volume -}}
{{ if eq "name" $key }}
{{ printf "name: %s" $value | indent 2}}
{{- else }}
{{- printf "%s:" $key }}
{{- toYaml $value | nindent 4}}
{{- end -}}
{{- end -}}
{{- end -}}
{{- end -}}
{{- end -}}